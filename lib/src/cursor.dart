import 'dart:async';
import 'dart:io';
import 'constants.dart';
import 'stdin.dart';

final _beginOfNumber = '0'.runes.first;
final _endOfNumber = '9'.runes.first;

/// Class for terminal cursor management
class ANSICursor {

	factory ANSICursor() => _instance ??= ANSICursor._();

	ANSICursor._();

	/// ANSICursor single instance
	static ANSICursor _instance;

	/// Store CursorPoint List
	/// Supports stored-point sequence，and locate specify point directly
	List<ANSICursorPoint> _savedCursorPoint;

	/// Move cursor up # lines
	/// - [lineCount] : line count
	/// - [beginOfLine] : move to line-start
	void upLine({int lineCount = 1, bool beginOfLine = true}) {
		assert(lineCount != null);
		assert(beginOfLine != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}${lineCount}A${beginOfLine ? '\r' : ''}');
		}
	}

	/// Move cursor down # lines
	/// - [lineCount] : line count
	/// - [beginOfLine] : move to line-start
	void downLine({int lineCount = 1, bool beginOfLine = true}) {
		assert(lineCount != null);
		assert(beginOfLine != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}${lineCount}B${beginOfLine ? '\r' : ''}');
		}
	}

	/// Move cursor right # space
	/// - [spaceCount] : space count
	void goRight({int spaceCount = 1}) {
		assert(spaceCount != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}${spaceCount}C');
		}
	}

	/// Move cursor left # space
	/// - [spaceCount] : space count
	void goLeft({int spaceCount = 1}) {
		assert(spaceCount != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}${spaceCount}D');
		}
	}

	/// Move cursor to line-start
	void beginLine() {
		stdout.write('\r');
	}

	/// Locate the cursor at specify point
	/// - [point] : specify cursor point
	void locateCursor({ANSICursorPoint point}) {
		assert(point != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}${point.row};${point.col}H');
		}
	}

	/// Store current cursor position
	/// Return the cursor point index in stored-point list
	///
	/// * Note that !
	///
	/// Screen will screen when output a lots message, so some old `stored-point`
	/// may be invalid, because it record the old point not now.
	///
	Future<int> storeCursorPoint() async {
		if(stdout.supportsAnsiEscapes) {
			stdin.echoMode = false;
			stdin.lineMode = false;
			final resultCompleter = Completer<List<int>>();
			final subscription = StdinManager().insertObserver((event) {
				if(!resultCompleter.isCompleted) {
					resultCompleter.complete(event);
				}
			});

			stdout.write('${kESC}6n');
			final eventList = await resultCompleter.future;
			subscription.cancel();
			stdin.echoMode = true;
			stdin.lineMode = true;
			final recvMsg = String.fromCharCodes(eventList);
			final splitArr = recvMsg.split(';');
			if (splitArr != null && splitArr.length == 2) {
				var rowNumber = -1;
				var colNumber = -1;
				// during traversal may be occur error, and interrupt this
				var isError = false;

				var codeUnitsList = splitArr[0].codeUnits;
				// traversal left side for row number
				for (var i = codeUnitsList.length - 1; i >= 0; i --) {
					final code = codeUnitsList[i];
					if (code >= _beginOfNumber && code <= _endOfNumber) {
						if (rowNumber == -1) {
							rowNumber = 0;
						}
						rowNumber = rowNumber * 10 + code - _beginOfNumber;
					}
					else {
						if (rowNumber == -1) {
							isError = true;
						}
						break;
					}
				}

				// occur error when traversal row number
				if (isError) {
					return -1;
				}

				codeUnitsList = splitArr[1].codeUnits;
				// traversal right side for col number
				for (var i = 0; i < codeUnitsList.length; i ++) {
					final code = codeUnitsList[i];
					if (code >= _beginOfNumber && code <= _endOfNumber) {
						if (colNumber == -1) {
							colNumber = 0;
						}
						colNumber = colNumber * 10 + code - _beginOfNumber;
					}
					else {
						if (colNumber == -1) {
							isError = true;
						}
						break;
					}
				}

				// occur error when traversal col number
				if (isError) {
					return -1;
				}

				// invert the number of rows in decimal
				var tempNumber = 0;
				while (rowNumber > 0) {
					tempNumber = tempNumber * 10 + rowNumber % 10;
					rowNumber ~/= 10;
				}
				rowNumber = tempNumber;

				_savedCursorPoint ??= [];
				final curIdx = _savedCursorPoint.length;
				_savedCursorPoint.add(ANSICursorPoint(row: rowNumber, col: colNumber));
				return curIdx;
			}

			return -1;
		}
		else {
			// current terminal do not support `ANSI Control Escape Sequence`
			return -1;
		}
	}

	/// Restore to position saved before.
	/// [storePointIdx] : stored-point index, return by [storeCursorPoint]. if this value is `-1`,
	/// means restore to the previous stored-point.
	///
	/// [popBefore] : pop all point stored after restored point
	///
	void restoreToSavePosition({int storePointIdx = -1, bool popBefore = true}) {
		assert(storePointIdx != null);
		assert(popBefore != null);
		if (stdout.supportsAnsiEscapes) {
			if(_savedCursorPoint == null || _savedCursorPoint.length == 0) {
				return;
			}

			var restoreIdx = storePointIdx != -1 ? storePointIdx : _savedCursorPoint.length - 1;

			if(restoreIdx >= _savedCursorPoint.length) {
				return;
			}

			locateCursor(point: _savedCursorPoint[restoreIdx]);
			if(popBefore) {
				_savedCursorPoint.removeRange(restoreIdx, _savedCursorPoint.length);
				if(_savedCursorPoint.length == 0) {
					_savedCursorPoint = null;
				}
			}
		}
	}
}

/// Represent terminal cursor's point
class ANSICursorPoint {
	ANSICursorPoint({int row = 1, int col = 1})
		: assert(row != null),
			assert(col != null),
			this.row = row,
			this.col = col;

	/// rowIdx
	final int row;

	/// colIdx
	final int col;

	@override
	String toString() => 'Cursor point{row => $row, col => $col}';
}