import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';

class AppDecoration {
  // Surface decorations
  static BoxDecoration get fillOnErrorContainer => BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
      );

  static BoxDecoration get fadeContainer => BoxDecoration(
    color: appTheme.black900.withAlpha(125),
  );

  static BoxDecoration get gradientRedToOnPrimary => BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.red90001, theme.colorScheme.onPrimary],
        ),
      );

  static BoxDecoration get outline => BoxDecoration(
        color: appTheme.red900,
        border: Border.all(
          color: appTheme.amber200,
          width: 8
        ),
        borderRadius: BorderRadiusStyle.roundedBorder20,
      );

  static BoxDecoration get outlineBlack => BoxDecoration();
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get circularBorder127 => BorderRadius.circular(
        127.h,
      );

  static BorderRadius get circularBorder17 => BorderRadius.circular(
        17.h,
      );

  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
}
