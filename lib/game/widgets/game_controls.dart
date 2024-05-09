import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_bloc/game_bloc.dart';


/*

class GameControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final isGameOver = state.playState == GameStatus.gameOver;
        final isLevelCompleted = state.playState == GameStatus.levelCompleted;
        return Column(
          children: [
            if (isGameOver) Text('Game Over'),
            if (isLevelCompleted) Text('Level Completed'),
            ElevatedButton(
              onPressed: () {
                if (isGameOver || state.playState == GameStatus.initial) {
                  context.read<GameBloc>().add(StartGame());
                } else if (isLevelCompleted) {
                  context.read<GameBloc>().add(NextLevel());
                }
              },
              child: Text(isGameOver || state.playState == GameStatus.initial ? 'Start Game' : 'Next Level'),
            ),
          ],
        );
      },
    );
  }
}*/
