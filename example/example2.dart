import 'dart:math';

import 'package:console_cmd/console_cmd.dart';

void main() async {
	final str = 'hello world';
	ANSIPrinter()
	// print red text
	..printRGB(str, fColor: 0xFF0000);
	ANSICursor()
	// move cursor up 1 line
	..upLine();
	for(final charCode in str.codeUnits) {
		// output a character per 0.5 seconds
		await Future.delayed(const Duration(milliseconds: 500));
		ANSIPrinter()
		..printRGB(
			String.fromCharCode(charCode),
			// do not break line, override text output before
			breakLine: false,
			fColor: Random().nextInt(0xFFFFFF),
		);
	}
	
	ANSICursor()
	// back to end
	..downLine();
}