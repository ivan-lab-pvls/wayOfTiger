import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/player_stats.dart';
import 'catch_game/catch_game.dart';

class MiniGameScreen extends StatefulWidget {
  const MiniGameScreen({super.key});

  static Widget builder(BuildContext context) {
    return MiniGameScreen();
  }

  @override
  State<MiniGameScreen> createState() => _MiniGameScreenState();
}

class _MiniGameScreenState extends State<MiniGameScreen> {
// Game Settings
  final int numberOfItems = 5;
  final Duration spawnInterval = Duration(milliseconds: 500);
  final double itemSpeed = 150; // pixels per second
  final Size itemSize = Size(50, 50);
  final List<String> itemSprites = [
    ImageConstant.imgStrawberry,
    ImageConstant.imgTwinapple,
    ImageConstant.imgLemon,
    ImageConstant.imgBlueberry,
    ImageConstant.imgApple,
    ImageConstant.imgCoin,
  ];

  // Game State
  List<Item> items = [];
  int score = 0;
  bool gameOver = false;
  Random random = Random();

  // Timers
  Timer? spawnTimer;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    gameTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    score = 0;
    gameOver = false;
    items.clear();

    spawnTimer = Timer.periodic(spawnInterval, (_) {
      spawnItem();
    });

    gameTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      updateGame();
    });
  }

  void updateGame() {
    if (gameOver) return;

    for (var item in List.from(items)) {
      item.position += Offset(0, itemSpeed * 0.016); // Update position

      if (item.position.dy > MediaQuery.of(context).size.height) {
        /*if (item is Bomb) {
          gameOver = true;
          gameTimer?.cancel();
          // Show Game Over Dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Game Over'),
              content: Text('Your final score: $score'),
              actions: [
                TextButton(
                  child: Text('Restart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startGame();
                  },
                ),
              ],
            ),
          );
        }*/
        items.remove(item);
      }
    }

    setState(() {}); // Rebuild widget to reflect changes
  }

  void spawnItem() {
    if (items.length >= numberOfItems) return;

    final isBomb = random.nextDouble() < 0.2; // 20% chance of bomb
    final position = Offset(
      random.nextDouble() *
          (MediaQuery.of(context).size.width - itemSize.width),
      -itemSize.height,
    );

    if (isBomb) {
      items.add(Bomb(
          position: position, size: itemSize, image: ImageConstant.imgBomb));
    } else {
      int randomIndex = random.nextInt(itemSprites.length);
      items.add(Item(
          position: position, size: itemSize, image: itemSprites[randomIndex]));
    }
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
                      Container(
                        width: 40.h,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgCoin,
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        score.toString(),
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80.h,
              ),
              /* IconButton(
                onPressed: () {},
                icon: CustomImageView(
                  imagePath: ImageConstant.imgSettingsBtn,
                ),
              ),*/
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            //color: Colors.black.withAlpha(1),
            imagePath: ImageConstant.imgMiniGameBack,
          ),
          ...items.map(
            (item) {
              return Positioned(
                left: item.position.dx,
                top: item.position.dy,
                child: GestureDetector(
                  onTap: () {
                    if (gameOver) return;

                    setState(() {
                      if (item is Bomb) {
                        gameOver = true;
                        gameTimer?.cancel();
                        gameOverPoUp(context);
                      } else {
                        score++;
                      }
                      items.remove(item);
                    });
                  },
                  child: Container(
                    width: itemSize.width,
                    height: itemSize.height,
                    child: CustomImageView(
                      imagePath: item.image,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void gameOverPoUp(
    BuildContext context,
  ) {
    PlayerStats.increaseBalance(score.toDouble());
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
                              'Game Over',
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
                            score.toString(),
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
                                Navigator.of(context).pop();
                                startGame();
                              },
                              icon: CustomImageView(
                                height: 100.v,
                                imagePath: ImageConstant.imgPlayBtn,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                startGame();
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
