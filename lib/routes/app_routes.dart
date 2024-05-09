import 'package:flutter/material.dart';
import 'package:tiger_fortune/data/models/level_model/level_model.dart';
import 'package:tiger_fortune/presentation/level_screen/level_screen.dart';
import 'package:tiger_fortune/presentation/main_screen/main_screen.dart';
import 'package:tiger_fortune/presentation/mini_game_screen/mini_game_screen.dart';
import 'package:tiger_fortune/presentation/shop_screen/shop_screen.dart';
import 'package:tiger_fortune/presentation/tiger_game_screen/tiger_game_screen.dart';

import '../presentation/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';
  static const String tigerGameScreen = '/tiger_game_screen';
  static const String miniGameScreen = '/mini_game_screen';
  static const String mainScreen = '/main_screen';
  static const String shopScreen = '/shop_screen';
  static const String settingsScreen = '/settings_screen';
  static const String levelScreen = '/level_screen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        mainScreen: MainScreen.builder,
        shopScreen: ShopScreen.builder,
        miniGameScreen: MiniGameScreen.builder,
        tigerGameScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as LevelModel;
          return TigerGameScreen.builder(context, arguments);
        },
        levelScreen: LevelScreen.builder,
        // transportInfoScreen: (context) {
        //   final arguments =
        //       ModalRoute.of(context)!.settings.arguments as BoatModel;
        //   return TransportInfoScreen.builder(context, arguments);
        // },
        // newsContentScreen: (context) {
        //   final arguments =.
        //       ModalRoute.of(context)!.settings.arguments as NewsModel;
        //   return NewsContentScreen.builder(context, arguments);
        // },
        // settingsScreen: SettingsScreen.builder,
      };
}
