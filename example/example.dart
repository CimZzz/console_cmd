import 'dart:io';


import '../lib/console_cmd.dart';

void main() {
	printRGB('123123123123123', fColor: 0xFF0000);
	printRGB('123123123123123', fColor: 0xFF0000);
	printRGB('123123123123123', fColor: 0xFF0000);
	printRGB('123123123123123', fColor: 0xFF0000);
	printRGB('123123123123123', fColor: 0xFF0000, breakLine: false);
	locateCursor(row: 2, col: 4);
	printRGB('h', fColor: 0xFF0000, breakLine: false);
	
}