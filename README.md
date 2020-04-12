# console_cmd

a series method for developing console application

about line-move, color text and clear method

## Usage

Latest version : 1.0.0

add in pubspec.yaml

```yaml
dependencies:
  console_cmd: ^1.0.0
```

### Print colorful text

```dart
/// Output RGB Color text
/// - [text] : text you want output
/// - [breakLine] : whether break line after output
/// - [fColor] : foreground color
/// - [fGray] : foreground color's grey scale value
/// - [bColor] : background color
/// - [bGray] : background color's grey scale value
void printRGB(String text, {bool breakLine = true, int fColor, double fGray, int bColor, double bGray})
```

---

### Cursor-Control

```dart
/// Move cursor up # lines
/// - [lineCount] : line count
/// - [beginOfLine] : move to line-start
void upLine({int lineCount = 1, bool beginOfLine = true})

/// Move cursor down # lines
/// - [lineCount] : line count
/// - [beginOfLine] : move to line-start
void downLine({int lineCount = 1, bool beginOfLine = true})

/// Move cursor right # space
/// - [spaceCount] : space count
void goRight({int spaceCount = 1})

/// Move cursor left # space
/// - [spaceCount] : space count
void goLeft({int spaceCount = 1})

/// Locate the cursor at [row,col]
/// - [row] : row
/// - [col] : column
void locateCursor({int row = 0, int col = 0})
```

---

### Erase method

```dart
/// Clear the screen and home cursor
void clearScreen()

/// Clear line until end
/// - [beginOfLine] : whether clear whole line
void clearLine({bool beginOfLine = true})
```

---

### Note this

Program must run in the `terminal or cmd`，if not take effect

> e.g. "dart xxx.dart" in your terminal instead of IDE run