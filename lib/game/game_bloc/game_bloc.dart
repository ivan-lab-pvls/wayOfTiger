import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState()) {
    on<StartGameEvent>(onStartGame);
    on<CellTappedEvent>(playerTap);
    on<HintEvent>(onHintTap);
  }

  List<int> generatedSequence = [];
  List<int> playerSequence = [];
  String text = '';

  onStartGame(StartGameEvent event, Emitter<GameState> emit) async {
    generatedSequence =
        await _generateSequence(event.gridCount, event.sequenceCount);

    emit(
      GameInitState(
        generatedSequence: generatedSequence,
        level: event.level,
        gridCount: event.gridCount,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    for (final colorIndex in generatedSequence) {
      emit(GameSequenceShowingState(
        index: colorIndex,
      ));
      await Future.delayed(Duration(
          seconds: 1)); // Задержка между изменениями цвета, можно настроить
      emit(GameSequenceShowingState(
        index: -1,
      ));
      await Future.delayed(Duration(seconds: 1)); //
    }
    emit(GamePlayingState());
  }

  playerTap(CellTappedEvent event, Emitter<GameState> emit) async {
    bool checkIsWrong = false;
    playerSequence.add(event.index);
    print('${playerSequence.length} - ${generatedSequence.length}');
    if (playerSequence.length == generatedSequence.length) {
      for (int i = 0; i < playerSequence.length; i++) {
        if (playerSequence[i] != generatedSequence[i]) {
          checkIsWrong = true;
        }
      }
      if (checkIsWrong) {
        text = 'TRY AGAiN';
        print('treu');

        emit(GameWrongState(isWrong: false));
        await Future.delayed(Duration(seconds: 1));
        emit(GameWrongState(isWrong: true));
        playerSequence.clear();
        await Future.delayed(Duration(seconds: 1));

        emit(GamePlayingState());
      } else {
        text = 'GOOD';
        print('Good');
        emit(
          GameOverWaitState(),
        );
        await Future.delayed(Duration(seconds: 3));
        emit(
          GameOverState(endCallback: event.endCallback ?? () {}),
        );
      }
      playerSequence.clear();
    } else {
      for (int i = 0; i < playerSequence.length; i++) {
        if (playerSequence[i] != generatedSequence[i]) {
          text = 'TRY AGAiN';
          print('treu');

          emit(GameWrongState(isWrong: false));
          await Future.delayed(Duration(seconds: 1));
          emit(GameWrongState(isWrong: true));

          playerSequence.clear();
          await Future.delayed(Duration(seconds: 1));
          emit(GamePlayingState());
          break;
        }
      }
    }
  }

  onHintTap(HintEvent event, Emitter<GameState> emit) async {
    int index = generatedSequence[playerSequence.length];
    emit(GameHintState(index: index));
    await Future.delayed(Duration(seconds: 1));
    emit(GamePlayingState());
  }

  List<int> _generateSequence(int max, int count) {
    if (count > max) {
      throw ArgumentError('Count must be less than or equal to max');
    }

    final random = Random();
    final numbers = <int>[];
    while (numbers.length < count) {
      final randomNumber = random.nextInt(max);
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }
    return numbers;
  }
}
