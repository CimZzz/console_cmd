import 'package:console_cmd/console_cmd.dart';

void main() async {

	ANSIPrinter()
	..printRGB('1234567890', fColor: 0xFF00FF, breakLine: false)
	..printRGB('')
	..print('')
	..print('2345656')
	..print('2345656')
	..print('2345656')
	..print('2345656')
	..print('hhhhhhh', breakLine: false);
	await ANSICursor().storeCursorPoint();
	ANSICursor()
	..upLine()
	..upLine()
	..upLine();
	ANSIPrinter().print('modifiy', breakLine: false);
	ANSICursor().restoreToSavePosition();
	ANSIPrinter()
	..print('bbbbbbbb', breakLine: false)
	..print('');
	StdinManager().close();
}