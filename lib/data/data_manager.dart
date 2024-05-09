import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_export.dart';
import 'models/level_model/level_model.dart';

class DataManager {
  static int maxOpenedLevel = 0; // Начальный открытый уровень
  static List<LevelModel> levels = []; // Список всех уровней
  // Инициализация списка уровней
  static void initializeLevels() {
    // Предположим, что у вас есть список уровней
    // Первые 10 уровней с GridCount = 4
    // Уровни с 20 по 29 с GridCount = 6
    // Уровни с 30 по 39 с GridCount = 12
    // Остальные с GridCount = 15
    for (int i = 0; i <= 50; i++) {
      int gridCount = 4;
      int rewardCount = 10;
      if (i >= 10 && i < 20) {
        gridCount = 6;
        rewardCount = 20;
      } else if (i >= 20 && i < 30) {
        gridCount = 9;
        rewardCount = 30;
      } else if (i >= 30 && i < 40) {
        gridCount = 12;
        rewardCount = 50;
      } else if (i >= 40) {
        gridCount = 15;
        rewardCount = 50;
      }
      levels.add(LevelModel(
        index: i,
        gridCount: gridCount,
        sequenceCount: 3,
        // Предположим, что у всех уровней одинаковое количество последовательностей
        rewardCount:
            rewardCount, // Предположим, что у всех уровней одинаковая награда
      ));
    }
  }

  // Загрузка прогресса игры
  static Future<int> loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    maxOpenedLevel = prefs.getInt('maxOpenedLevel') ?? 1;
    return maxOpenedLevel;
  }

  // Сохранение прогресса игры
  static void saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('maxOpenedLevel', maxOpenedLevel);
  }

  static List<String> mainGameImages = [
    ImageConstant.img1,
    ImageConstant.img2,
    ImageConstant.img3,
    ImageConstant.img4,
    ImageConstant.img5,
    ImageConstant.img6,
    ImageConstant.img7,
    ImageConstant.img8,
    ImageConstant.img9,
    ImageConstant.img10,
    ImageConstant.img11,
    ImageConstant.img12,
    ImageConstant.img13,
    ImageConstant.img14,
    ImageConstant.img15,
    ImageConstant.img16,
    ImageConstant.img17,
    ImageConstant.img18,
    ImageConstant.img19,
    ImageConstant.img20,
    ImageConstant.img21,
    ImageConstant.img22,
    ImageConstant.img23,
    ImageConstant.img24,
    ImageConstant.img25,
    ImageConstant.img26,
    ImageConstant.img27,
    ImageConstant.img28,
    ImageConstant.img29,
    ImageConstant.img30,
    ImageConstant.img31,
    ImageConstant.img32,
    ImageConstant.img33,
    ImageConstant.img34,
    ImageConstant.img35,
    ImageConstant.img36,
  ];

  static List<String> generateRandomList() {
    // Создаем копию входного списка, чтобы не изменять его оригинал
    List<String> randomList = List<String>.from(mainGameImages);

    // Создаем генератор случайных чисел
    Random random = Random();

    // Перемешиваем элементы списка случайным образом
    for (int i = randomList.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      String temp = randomList[i];
      randomList[i] = randomList[j];
      randomList[j] = temp;
    }

    return randomList;
  }
}
