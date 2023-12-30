import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:to_ryu_mon_2024/fish.dart';
import 'package:to_ryu_mon_2024/game/to_ryu_mon_game.dart';
import 'package:to_ryu_mon_2024/notifier/game_controller_notifier.dart';
import 'package:to_ryu_mon_2024/page/result_view.dart';
import 'package:to_ryu_mon_2024/page/top_info_view.dart';
import 'package:to_ryu_mon_2024/view/area_restrict_view.dart';

class ToRyuMonPage extends StatefulWidget {
  const ToRyuMonPage({super.key});

  @override
  State<ToRyuMonPage> createState() => _ToRyuMonPageState();
}

class _ToRyuMonPageState extends State<ToRyuMonPage> {
  late final IToRyuMonGame game;
  late final GameController gameController;
  late final Timer _fishInfoTimer;
  int fishIndex = 0;
  late Fish _fish;

  @override
  void initState() {
    super.initState();
    gameController = GameController();
    game = ToRyuMonGameImpl(
      scoreNotifier: gameController,
    );

    _fish = Fish.fishList[fishIndex];
    _fishInfoTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fish = Fish.fishList[++fishIndex % Fish.fishList.length];
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fishInfoTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF7ACDFF),
        body: AreaRestrictView(
            child: ClipRect(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TopInfoView(
                      score: gameController.score,
                      fish: _fish,
                    ),
                    Expanded(child: GameWidget(game: game)),
                  ],
                ),
              ),
              if (gameController.gameState == GameState.gameOver)
                Positioned.fill(
                  child: ResultView(
                      onRestart: () {
                        FirebaseAnalytics.instance.logEvent(name: "game_restart");
                        gameController.start();
                      },
                      score: gameController.score),
                ),
            ],
          ),
        )));
  }
}
