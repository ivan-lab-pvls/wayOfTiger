part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGameEvent extends GameEvent {
  final int gridCount;

  final int sequenceCount;
  final int level;

  StartGameEvent({
    required this.gridCount,
    required this.level,
    required this.sequenceCount,
  });
}

class CellTappedEvent extends GameEvent {
  final int index;
  final VoidCallback? endCallback;

  CellTappedEvent(
    this.index, {
    this.endCallback,
  });

  @override
  List<Object> get props => [index];
}

class HintEvent extends GameEvent {}

class NextLevelEvent extends GameEvent {}

class RestartGameEvent extends GameEvent {}
