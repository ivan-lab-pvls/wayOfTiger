import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static BoxDecoration get gradientDeepOrangeAToPrimaryContainerDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(20.h),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.red900,
            appTheme.red90002,
          ],
        ),
      );

  static ButtonStyle get outline => OutlinedButton.styleFrom(
        backgroundColor: appTheme.red900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        side: BorderSide(
          color: appTheme.amber200.withOpacity(1),
          width: 7,
        ),
      );

  static ButtonStyle get outlineGray => OutlinedButton.styleFrom(
        backgroundColor: appTheme.gray600,
        side: BorderSide(
          color: appTheme.gray400.withOpacity(1),
          width: 7,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
      );

  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
