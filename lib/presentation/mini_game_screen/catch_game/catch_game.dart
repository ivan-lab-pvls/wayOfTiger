/*
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CatchGame extends FlameGame with TapDetector {
  late TextComponent scoreText;
  late TextComponent gameOverText;
  Random rnd = Random();

  final ValueNotifier<int> scoreNotifier = ValueNotifier(0);

  int get score => scoreNotifier.value;

  set score(int newScore) => scoreNotifier.value = newScore;

  final ValueNotifier<bool> gameOverNotifier = ValueNotifier(false);

  bool get gameOver => gameOverNotifier.value;

  set gameOver(bool isGameOver) => gameOverNotifier.value = isGameOver;

  @override
  Future<void>? onLoad() async {
    // Load images and sounds
    // ...

    // Add background
    add(SpriteComponent()
      ..sprite = await loadSprite('img_mini_game_back.png')
      ..size = size);

    // Add game over text (initially hidden)
    gameOverText = TextComponent(
      text: '',
      position: size / 2,
      anchor: Anchor.center,
    );
    // gameOverText.call = false;
    add(gameOverText);
    scoreText = TextComponent(text: 'Score: 0', position: Vector2(10, 10));
    add(scoreText);

  }

  @override
  void update(double dt) {
    super.update(dt);

    // Adjust spawn rates as needed
    if (rnd.nextDouble() < 0.01) {
      spawnItem();
    }
    if (rnd.nextDouble() < 0.005) {
      spawnBomb();
    }
  }

  void spawnItem() {
    Vector2 initialSize = Vector2(50, 50);
    Vector2 position = Vector2(rnd.nextDouble() * (size.x - initialSize.x), 0);

    // Randomly choose an item sprite
    final itemSprites = [
      'img_strawberry.png',
      'img_twinapple.png',
      'img_lemon.png',
      'img_blueberry.png',
      'img_apple.png',
      'img_coin.png'
    ]; // Add your item image paths
    final randomSprite = itemSprites[rnd.nextInt(itemSprites.length)];
    add(Item(position: position, size: initialSize, spritePath: randomSprite));
  }

  void spawnBomb() {
    Vector2 initialSize = Vector2(50, 50);
    Vector2 position = Vector2(rnd.nextDouble() * (size.x - initialSize.x), 0);
    add(Bomb(position: position, size: initialSize));
  }

  @override
  void onTapDown(TapDownInfo info) {
    //super.onTapDown(info);
    bool isGameOver = false;
    for (var item in children.query<Item>()) {
      if (item.containsPoint(info.eventPosition.global)) {
        score++;
        item.removeFromParent();
        // ... play sound etc.
      }
    }

    // Check for bomb taps
    for (var bomb in children.query<Bomb>()) {
      if (bomb.containsPoint(info.eventPosition.global)) {
        isGameOver = true;
        break; // Game over, no need to check other bombs
      }
    }

    if (isGameOver) {
      gameOverText.text = 'Game Over';
      pauseEngine();
    } else {
     scoreText.text = 'Score: $score';
    }
  }
}

class Item extends SpriteComponent with HasGameRef {
  final String spritePath;

  Item({
    required super.position,
    required super.size,
    required this.spritePath,
  });

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(spritePath);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 150 * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}

class Bomb extends SpriteComponent with HasGameRef {
  Bomb({required super.position, required super.size});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('img_bomb.png'); // Add your bomb image
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 150 * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
*/
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';

class CatchGame extends StatefulWidget {
  @override
  _CatchGameState createState() => _CatchGameState();
}

class _CatchGameState extends State<CatchGame> {
  // Game Settings
  final int numberOfItems = 5;
  final Duration spawnInterval = Duration(milliseconds: 500);
  final double itemSpeed = 150; // pixels per second
  final Size itemSize = Size(50, 50);

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
        if (item is Bomb) {
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
        }
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
      /*  int randomIndex = random.nextInt(itemSp.length);
      items.add(Item(position: position, size: itemSize));*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background (replace with your background image)
        //Container(color: Colors.blue),
        // Score Display
        Positioned(
          top: 20,
          left: 20,
          child: Text('Score: $score',
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        // Game Items
        ...items.map((item) => Positioned(
              left: item.position.dx,
              top: item.position.dy,
              child: GestureDetector(
                onTap: () {
                  if (gameOver) return;

                  setState(() {
                    items.remove(item);
                    if (item is! Bomb) score++;
                  });
                },
                child: Container(
                  width: itemSize.width,
                  height: itemSize.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item is Bomb ? Colors.red : Colors.green,
                  ),
                  child: CustomImageView(
                    imagePath: item is Bomb
                        ? ImageConstant.imgBomb
                        : ImageConstant.imgApple,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class Item {
  Offset position;
  Size size;
  String image;

  Item({required this.position, required this.size, required this.image});
}

class Bomb extends Item {
  Bomb({required super.position, required super.size, required super.image});
}
