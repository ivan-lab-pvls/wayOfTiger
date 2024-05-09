part of 'game_bloc.dart';

enum GameStatus { initial, playing, showingSequence, levelCompleted, gameOver }

class GameState {}

class GameInitState extends GameState {
  final List<int> generatedSequence;
  final int gridCount;
  final int level;

  GameInitState({
    required this.generatedSequence,
    required this.level,
    required this.gridCount,
  });
}

class GameSequenceShowingState extends GameState {
  final int index;

  GameSequenceShowingState({required this.index});
}
class GameHintState extends GameState {
  final int index;

  GameHintState({required this.index});
}
class GamePlayingState extends GameState {}

class GameWrongState extends GameState {
  final bool isWrong;

  GameWrongState({required this.isWrong});
}

class GameOverWaitState extends GameState
{

}

class GameOverState extends GameState {
  final VoidCallback endCallback;

  GameOverState({required this.endCallback});
}
