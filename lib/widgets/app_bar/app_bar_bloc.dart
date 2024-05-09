import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/player_stats.dart';

part 'app_bar_event.dart';

part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc()
      : super(AppBarState(
      balance: PlayerStats.balance, hintCount: PlayerStats.hintCount)) {
    // Загружаем данные из SharedPreferences при инициализации
    _loadPlayerStatsFromPrefs();

    PlayerStats.balanceStream.listen((life) {
      add(UpdateCoin(life));
    });
    PlayerStats.hintStream.listen((energy) {
      add(UpdateHint(energy));
    });
    on<UpdateCoin>((event, emit) {
      PlayerStats.balance = event.balance;
      _saveBalanceToPrefs(event.balance); // Сохраняем баланс в SharedPreferences
      emit(AppBarState(balance: event.balance, hintCount: state.hintCount));
    });

    on<UpdateHint>((event, emit) {
      PlayerStats.hintCount = event.hintCount;
      _saveHintCountToPrefs(event.hintCount); // Сохраняем количество подсказок в SharedPreferences
      emit(AppBarState(balance: state.balance, hintCount: event.hintCount));
    });
  }
  // Метод для загрузки данных из SharedPreferences
  Future<void> _loadPlayerStatsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double balance = prefs.getDouble('balance') ?? PlayerStats.balance;
    int hintCount = prefs.getInt('hintCount') ?? PlayerStats.hintCount;

    // Обновляем значения в PlayerStats и в состоянии блока
    PlayerStats.balance = balance;
    PlayerStats.hintCount = hintCount;
    add(UpdateCoin(balance));
    add(UpdateHint(hintCount));
  }

  // Метод для сохранения баланса в SharedPreferences
  Future<void> _saveBalanceToPrefs(double balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  // Метод для сохранения количества подсказок в SharedPreferences
  Future<void> _saveHintCountToPrefs(int hintCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hintCount', hintCount);
  }
}
