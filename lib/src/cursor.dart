import 'dart:io';
import 'constants.dart';

/// Move cursor up # lines
/// - [lineCount] : line count
/// - [beginOfLine] : move to line-start
void upLine({int lineCount = 1, bool beginOfLine = true}) {
	assert(lineCount != null);
	assert(beginOfLine != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}${lineCount}A${beginOfLine ? '\r' : ''}');
	}
}

/// Move cursor down # lines
/// - [lineCount] : line count
/// - [beginOfLine] : move to line-start
void downLine({int lineCount = 1, bool beginOfLine = true}) {
	assert(lineCount != null);
	assert(beginOfLine != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}${lineCount}B${beginOfLine ? '\r' : ''}');
	}
}

/// Move cursor right # space
/// - [spaceCount] : space count
void goRight({int spaceCount = 1}) {
	assert(spaceCount != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}${spaceCount}C');
	}
}

/// Move cursor left # space
/// - [spaceCount] : space count
void goLeft({int spaceCount = 1}) {
	assert(spaceCount != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}${spaceCount}D');
	}
}

/// Move cursor to line-start
void beginLine() {
	if(stdout.supportsAnsiEscapes) {
		stdout.write('\r');
	}
}

/// Locate the cursor at [row,col]
/// - [row] : row
/// - [col] : column
void locateCursor({int row = 0, int col = 0}) {
	assert(row != null);
	assert(col != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}${row};${col}H');
	}
}