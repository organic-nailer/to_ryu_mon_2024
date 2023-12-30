import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:to_ryu_mon_2024/fish.dart';
import 'package:to_ryu_mon_2024/game/to_ryu_mon_game.dart';

class FishComponent extends PositionComponent
    with HasGameReference<IToRyuMonGame>, GestureHitboxes, TapCallbacks {
  double velocity;
  final String img;
  final List<List<Vector2>>? tapAreaList;
  final bool isKoi;
  FishComponent(
      {super.position,
      required this.img,
      this.tapAreaList,
      required this.isKoi,
      this.velocity = -100});

  FishComponent.fromFish(Fish fish, {super.position, this.velocity = -100})
      : img = fish.img,
        tapAreaList = fish.tapAreaList,
        isKoi = fish.isKoi;

  static FishComponent getRandomFish() {
    final fish = Fish.getRandomFish();
    return FishComponent.fromFish(fish);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    width = game.getAbsoluteX(0.5);
    height = width * 3 / 3;
    anchor = Anchor.center;

    final splash = SpriteAnimationComponent();
    splash.animation =  await game.loadSpriteAnimation(
      "splash.png", 
      SpriteAnimationData.sequenced(amount: 4, stepTime: 0.1, textureSize: Vector2(320,320)));
    splash.position = Vector2(width / 2, height * 0.6);
    splash.anchor = Anchor.center;
    splash.width = width * 0.5;
    splash.height = height * 0.8;
    add(splash);
    
    final body = _FishBody(
      img: img,
      tapAreaList: tapAreaList,
      isKoi: isKoi,
      onTap: onTap,
    )
    ..size = size
    ..position = Vector2(width / 2, height / 2);
    add(body);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * velocity;

    if (isKoi && position.y < 100) {
      // print("game over");
      game.gameOver();
    }

    if (position.y < -height) {
      removeFromParent();
    }
  }

  void onTap() {
    removeFromParent();
    if (isKoi) {
      game.incrementScore();
    } else {
      game.gameOver();
    }
  }
}

class _FishBody extends SpriteComponent
    with HasGameReference<IToRyuMonGame>, GestureHitboxes, TapCallbacks {
  final String img;
  final List<List<Vector2>>? tapAreaList;
  final bool isKoi;
  final Function? onTap;
  _FishBody({required this.img, required this.tapAreaList, required this.isKoi, this.onTap});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
    angle = pi / 2;
    
    sprite = await game.loadSprite(img);

    tapAreaList?.forEach((tapArea) {
      final absolutePolygon =
          tapArea.map((e) => Vector2(width * e.x, height * e.y)).toList();
      add(PolygonHitbox(absolutePolygon)
        ..paint.color = Colors.red.withAlpha(100)
        ..renderShape = false);
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap?.call();
  }
}
