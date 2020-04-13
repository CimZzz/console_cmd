import 'dart:io';
import 'constants.dart';

/// Class for erase method
class ANSIErase {
	
	factory ANSIErase() => _instance ??= ANSIErase._();
	
	ANSIErase._();
	
	/// ANSIErase single instance
	static ANSIErase _instance;
	
	/// Clear the screen and home cursor
	void clearScreen() {
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${kESC}2J');
		}
	}
	
	/// Clear line until end
	/// - [beginOfLine] : whether clear whole line
	void clearLine({bool beginOfLine = true}) {
		assert(beginOfLine != null);
		if (stdout.supportsAnsiEscapes) {
			stdout.write('${beginOfLine ? '\r' : ''}${kESC}K');
		}
	}
}
