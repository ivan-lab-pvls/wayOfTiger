import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_bloc/game_bloc.dart';
import 'game_cell.dart';

/*class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<GameBloc>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Simon'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Simon Says...'),
                const SizedBox(height: 20),
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: state.cells
                          .map((color) => GameCell(
                                color: color,
                                onTap: () => bloc.playerTap(color),
                              ))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    bloc.startGame();
                  },
                  child: const Text('Start Game'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}*/
