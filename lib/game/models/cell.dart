

import 'color.dart';
enum ColorType { red, green, blue, yellow }
class Cell {
  final ColorType color;
  final bool isShown;

  Cell({
    required this.color,
    this.isShown = false,
  });

  Cell copyWith({
    ColorType? color,
    bool? isShown,
  }) {
    return Cell(
      color: color ?? this.color,
      isShown: isShown ?? this.isShown,
    );
  }
}