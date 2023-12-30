import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:to_ryu_mon_2024/game/fish_component.dart';
import 'package:to_ryu_mon_2024/game/my_spawn_component.dart';
import 'package:to_ryu_mon_2024/notifier/game_controller_notifier.dart';

abstract class IToRyuMonGame extends FlameGame {
  void incrementScore();
  void gameOver();

  double getAbsoluteX(double relativeX);
  double getAbsoluteY(double relativeY);

  Vector2 getAbsolutePosition(Vector2 relativePosition);
}

class ToRyuMonGameImpl extends FlameGame implements IToRyuMonGame {
  final GameController scoreNotifier;
  ToRyuMonGameImpl({required this.scoreNotifier, super.camera});

  late HomeGameView _homeGameView;

  @override
  Color backgroundColor() => const Color(0xFF7ACDFF);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _homeGameView = HomeGameView();
    add(_homeGameView);

    scoreNotifier.addListener(() {
      if (scoreNotifier.gameState == GameState.playing) {
        if (paused) {
          resumeEngine();
          _homeGameView.cleanUp();
        }
      }
    });
  }

  @override
  void incrementScore() {
    scoreNotifier.incrementScore();
  }

  @override
  void gameOver() {
    pauseEngine();
    scoreNotifier.gameOver();
  }

  @override
  Vector2 getAbsolutePosition(Vector2 relativePosition) {
    return Vector2(
      getAbsoluteX(relativePosition.x),
      getAbsoluteY(relativePosition.y),
    );
  }

  @override
  double getAbsoluteX(double relativeX) => relativeX * size.x;

  @override
  double getAbsoluteY(double relativeY) => relativeY * size.y;
}

class HomeGameView extends Component with HasGameRef<IToRyuMonGame> {
  late final MySpawnComponent spawner;
  late final TimerComponent _timerComponent;
  late final SpriteComponent _bg;
  late final SpriteComponent _bgGoal;
  late final SpriteComponent _bgRock;
  late final SpriteComponent _bgRock2;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    const topOffset = 50.0;

    _bg = SpriteComponent(sprite: await game.loadSprite("bg_fall.jpg"))
      ..position = Vector2(0, topOffset)
      ..size = game.size;
    add(_bg);

    _bgGoal = SpriteComponent(sprite: await game.loadSprite("gate.png"))
      ..position = Vector2(0, 0)
      ..width = game.size.x
      ..height = game.size.x * 4 / 9
      ..priority = 2;
    add(_bgGoal);

    _bgRock = SpriteComponent(sprite: await game.loadSprite("bg_rock.png"))
      ..position = Vector2(-350, 50 + topOffset)
      ..width = 400
      ..height = game.size.y
      ..priority = 3;
    add(_bgRock);
    _bgRock2 = SpriteComponent(sprite: await game.loadSprite("bg_rock.png"))
      ..position = Vector2(game.size.x - 50, 50 + topOffset)
      ..anchor = Anchor.topRight
      ..width = 400
      ..height = game.size.y
      ..priority = 3;
    _bgRock2.flipHorizontallyAroundCenter();
    add(_bgRock2);

    final random = Random();
    spawner = MySpawnComponent.periodRange(
      factory: (x) {
        final velocity = 50 + random.nextDouble() * 100 * (sqrt(x) / 2);
        final fish = FishComponent.getRandomFish()..priority = 1;
        fish.velocity = -velocity;
        return fish;
      },
      minPeriod: 0.5,
      maxPeriod: 2.5,
      area: Rectangle.fromLTWH(20, game.size.y + 100, game.size.x - 20, 100),
    );
    // spawner.minPeriod = 0.5;
    // spawner.maxPeriod = 2;
    add(spawner);
    
    _timerComponent = TimerComponent(
      period: 3,
      repeat: true,
      onTick: () {
        spawner.maxPeriod = max(0.5, spawner.maxPeriod! - 0.1);
        print("maxPeriod: ${spawner.maxPeriod}");
      },
    );
    add(_timerComponent);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    spawner.area = Rectangle.fromLTWH(0, game.size.y * 1.2, game.size.x, game.size.y * 0.05);
    _bg.size = game.size;
    _bgGoal.width = game.size.x;
    _bgGoal.height = game.size.x * 4 / 9;
    _bgRock.height = game.size.y;
    _bgRock2.height = game.size.y;
    _bgRock2.position = Vector2(game.size.x - 50, 50);
  }

  void cleanUp() {
    for (var element in children) {
      if (element is FishComponent) {
        element.removeFromParent();
      }
    }
    final random = Random();
    spawner.amount = 0;
    spawner.maxPeriod = 2;
  }
}
