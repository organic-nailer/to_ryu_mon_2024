import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  int _score = 0;
  GameState _gameState = GameState.home;
  VoidCallback? _onGameOver;

  int get score => _score;
  GameState get gameState => _gameState;

  void start() {
    _gameState = GameState.playing;
    _score = 0;
    notifyListeners();
    FirebaseAnalytics.instance.logEvent(name: "game_start");
  }

  void gameOver() {
    _gameState = GameState.gameOver;
    _onGameOver?.call();
    notifyListeners();
    FirebaseAnalytics.instance.logEvent(name: "game_over", parameters: {
      "score": _score,
    });
    FirebaseAnalytics.instance.logPostScore(score: _score);
  }

  void incrementScore() {
    _score += 10;
    notifyListeners();
  }

  void setOnGameOver(VoidCallback onGameOver) {
    _onGameOver = onGameOver;
  }
}

enum GameState {
  home,
  playing,
  gameOver,
}

class GameControllerProvider extends InheritedNotifier<GameController> {
  const GameControllerProvider({
    super.key,
    required super.child,
    required GameController notifier,
  }) : super(notifier: notifier);

  static GameController of(BuildContext context) {
    final notifier = context
        .dependOnInheritedWidgetOfExactType<GameControllerProvider>()
        ?.notifier;
    assert(notifier != null, 'No ScoreProvider found in context');
    return notifier!;
  }
}
