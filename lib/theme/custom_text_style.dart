import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get headLineLargeOnErrorContainer =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 32.fSize,
      );

  static get inknutAntiquaOnErrorContainer => TextStyle(
          color: theme.colorScheme.onErrorContainer,
          fontSize: 102.fSize,
          fontWeight: FontWeight.w700)
      .inknutAntiqua;

  static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
      );

  static get titleMediumPoppins => theme.textTheme.titleMedium!.poppins;
}

extension on TextStyle {
  TextStyle get inknutAntiqua {
    return copyWith(
      fontFamily: 'Inknut Antiqua',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
