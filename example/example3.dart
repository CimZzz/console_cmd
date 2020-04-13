import 'dart:math';

import 'package:console_cmd/console_cmd.dart';

void main() async {
	ANSIPrinter()
	// print red text
	..printRGB('hello world', fColor: 0xFF0000)
	..printRGB('i like banana', fColor: 0x00FF00)
	..printRGB('i love dart !', fColor: 0xFF00FF);
	
	// wait 3 seconds, clear screen
	await Future.delayed(const Duration(seconds: 3));
	
	// clear
	ANSIErase()
	..clearScreen();
}