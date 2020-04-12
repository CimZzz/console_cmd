import 'dart:io';
import 'constants.dart';

/// Clear the screen and home cursor
void clearScreen() {
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${kESC}2J');
	}
}

/// Clear line until end
/// - [beginOfLine] : whether clear whole line
void clearLine({bool beginOfLine = true}) {
	assert(beginOfLine != null);
	if(stdout.supportsAnsiEscapes) {
		stdout.write('${beginOfLine ? '\r' : ''}${kESC}K');
	}
}