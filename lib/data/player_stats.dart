import 'dart:async';

class PlayerStats {
  static double balance = 100;
  static int hintCount = 3;

  static final _balanceController = StreamController<double>.broadcast();
  static final _hintController = StreamController<int>.broadcast();

  static Stream<double> get balanceStream => _balanceController.stream;
  static Stream<int> get hintStream => _hintController.stream;

  static void increaseBalance(double amount) {
    balance += amount;
    _balanceController.add(balance);
  }

  static void decreaseBalance(double amount) {
    balance -= amount;
    if (balance < 0) balance = 0;
    _balanceController.add(balance);
  }

  static void increaseHint(int amount) {
    hintCount += amount;
    _hintController.add(hintCount);
  }

  static void decreaseHint(int amount) {
    hintCount -= amount;
    if (hintCount < 0) hintCount = 0;
    _hintController.add(hintCount);
  }
}
