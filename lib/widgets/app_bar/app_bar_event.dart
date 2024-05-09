part of 'app_bar_bloc.dart';

@immutable
abstract class AppBarEvent {}

class UpdateCoin extends AppBarEvent {
  final double balance;

  UpdateCoin(this.balance);
}

class UpdateHint extends AppBarEvent {
  final int hintCount;

  UpdateHint(this.hintCount);
}
