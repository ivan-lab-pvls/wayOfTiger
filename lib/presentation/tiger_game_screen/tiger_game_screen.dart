import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';
import 'package:tiger_fortune/data/models/level_model/level_model.dart';
import 'package:tiger_fortune/data/player_stats.dart';

import '../../data/data_manager.dart';
import '../../game/game_bloc/game_bloc.dart';
import '../../game/widgets/game_cell.dart';
import '../../widgets/app_bar/app_bar_bloc.dart';

class TigerGameScreen extends StatefulWidget {
  final LevelModel levelModel;

  const TigerGameScreen({
    super.key,
    required this.levelModel,
  });

  static Widget builder(BuildContext context, LevelModel level) {
    return BlocProvider<GameBloc>(
      create: (context) => GameBloc()
        ..add(
          StartGameEvent(
            gridCount: level.gridCount,
            level: level.index,
            sequenceCount: level.sequenceCount,
          ),
        ),
      child: TigerGameScreen(
        levelModel: level,
      ),
    );
  }

  @override
  State<TigerGameScreen> createState() => _TigerGameScreenState();
}

class _TigerGameScreenState extends State<TigerGameScreen> {
  List<String> images = [];

  @override
  void initState() {
    images = DataManager.generateRandomList();
    callTime = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  NavigatorService.goBack();
                },
                icon: CustomImageView(
                  imagePath: ImageConstant.imgLeftBtn,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Container(
                  width: 120.h,
                  padding: EdgeInsets.all(5.h),
                  decoration: AppDecoration.outline,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LEVEL ${widget.levelModel.index+1}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<GameBloc>().add(
                        StartGameEvent(
                          gridCount: widget.levelModel.gridCount,
                          level: widget.levelModel.index,
                          sequenceCount: widget.levelModel.sequenceCount,
                        ),
                      );
                },
                icon: CustomImageView(
                  imagePath: ImageConstant.imgRestartBtn,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            //color: Colors.black.withAlpha(1),
            imagePath: ImageConstant.imgBack,
          ),
          Center(
            child: _gamePanel(context, images),
          ),
        ],
      ),
    );
  }

  int currentIndex = -1;
  int callTime = 0;
  String message = '';

  Widget _gamePanel(BuildContext context, List<String> images) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: widget.levelModel.gridCount < 5
                      ? EdgeInsets.all(50.h)
                      : EdgeInsets.all(1.h),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.levelModel.gridCount < 5 ? 2 : 3,
                    ),
                    shrinkWrap: true,
                    itemCount: widget.levelModel.gridCount,
                    itemBuilder: (BuildContext context, int index) {
                      message = context.read<GameBloc>().text;
                      return BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          if (state is GameInitState) {
                            callTime == 0;
                            message = '';
                            return Center(
                              child: Container(),
                            );
                          } else if (state is GameSequenceShowingState) {
                            callTime == 0;
                            return GameCell(
                              image: images[index],
                              index: index,
                              currentIndex: state.index,
                              onTap: () {},
                              isWrong: false,
                              // child: Center(child: Text('$index')),
                            );
                          } else if (state is GamePlayingState) {
                            return GameCell(
                              image: images[index],
                              index: index,
                              currentIndex: -1,
                              onTap: () {
                                context.read<GameBloc>().add(
                                        CellTappedEvent(index, endCallback: () {
                                      levelDonePopUp(
                                          context, context.read<GameBloc>());
                                    }));
                              },
                              isWrong: false,
                              // child: Center(child: Text('$index')),
                            );
                          } else if (state is GameWrongState) {
                            message = 'TRY AGAIN';

                            return GameCell(
                              image: images[index],
                              index: index,
                              currentIndex: -1,
                              onTap: null,
                              isWrong: state.isWrong,
                              // child: Center(child: Text('$index')),
                            );
                          } else if (state is GameOverWaitState) {
                            message = 'GOOD';
                            return GameCell(
                              image: images[index],
                              index: index,
                              currentIndex: -1,
                              onTap: () {},
                              isWrong: false,
                              // child: Center(child: Text('$index')),
                            );
                          } else if (state is GameHintState) {
                            message = 'HINT';
                            return GameCell(
                              image: images[index],
                              index: index,
                              currentIndex: state.index,
                              onTap: null,
                              isWrong: false,
                              // child: Center(child: Text('$index')),
                            );
                          } else if (state is GameOverState) {
                            Future.delayed(Duration.zero, () {
                              if (callTime == 0) {
                                PlayerStats.increaseBalance(
                                    widget.levelModel.rewardCount.toDouble());
                                levelDonePopUp(
                                    context, context.read<GameBloc>());
                                callTime = 1;
                              }
                            });
                            return Container();
                          } else {
                            return ElevatedButton(
                              child: Text('StartGame'),
                              onPressed: () {
                                context.read<GameBloc>().add(StartGameEvent(
                                    gridCount: 3, level: 0, sequenceCount: 3));
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AppBarBloc, AppBarState>(
                    bloc: AppBarBloc(),
                    builder: (context, state) {
                      return Container(
                        height: 100.v,
                        width: 100.h,
                        child: IconButton(
                          icon: CustomImageView(
                            imagePath: PlayerStats.hintCount <= 0
                                ? ImageConstant.imgQuestionBtnDisable
                                : ImageConstant.imgQuestionBtn,
                          ),
                          onPressed: () {
                            if (PlayerStats.hintCount > 0) {
                              PlayerStats.decreaseHint(1);
                              context.read<GameBloc>().add(HintEvent());
                            }
                            // levelDonePopUp();
                          },
                        ),
                      );
                    }),
                BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                  if (state is GameInitState) {
                    return Text(
                      '',
                      style: theme.textTheme.titleLarge,
                    );
                  } else if (state is GameWrongState) {
                    return Text(
                      'WRONG',
                      style: theme.textTheme.titleLarge,
                    );
                  } else if (state is GameOverWaitState) {
                    return Text(
                      'GOOD',
                      style: theme.textTheme.titleLarge,
                    );
                  } else {
                    return Text(
                      message,
                      style: theme.textTheme.titleLarge,
                    );
                  }
                }),
                Container(
                  height: 100.v,
                  width: 100.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void levelDonePopUp(BuildContext context, GameBloc bloc) {
    DataManager.maxOpenedLevel++;
    DataManager.saveProgress();
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return Container(
          decoration: AppDecoration.outlineBlack,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Center(
                child: Container(
                  child: Material(
                    type: MaterialType.transparency,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgElderScroll,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 450.v,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Container(
                          width: 200.h,
                          height: 60.v,
                          //  padding: EdgeInsets.all(5.h),
                          decoration: AppDecoration.outline,
                          child: Center(
                            child: Text(
                              'LEVEL DONE',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.v,
                            child: Material(
                              type: MaterialType.transparency,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgCoin,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(
                            widget.levelModel.rewardCount.toString(),
                            style: theme.textTheme.headlineLarge
                                ?.copyWith(color: appTheme.brown),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.v),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                NavigatorService.pushNamedAndRemoveUntil(
                                  AppRoutes.mainScreen,
                                );
                              },
                              focusColor: Colors.transparent,
                              icon: CustomImageView(
                                height: 60.v,
                                imagePath: ImageConstant.imgMenuBtn,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                NavigatorService.popAndPushNamed(
                                    AppRoutes.tigerGameScreen,
                                    arguments: DataManager
                                        .levels[widget.levelModel.index + 1]);
                              },
                              icon: CustomImageView(
                                height: 100.v,
                                imagePath: ImageConstant.imgPlayBtn,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                callTime = 0;

                                bloc.add(
                                  StartGameEvent(
                                    gridCount: widget.levelModel.gridCount,
                                    level: widget.levelModel.index,
                                    sequenceCount:
                                        widget.levelModel.sequenceCount,
                                  ),
                                );
                                NavigatorService.goBack();
                              },
                              icon: CustomImageView(
                                height: 65.v,
                                imagePath: ImageConstant.imgRestartBtn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }
}
