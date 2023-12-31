import 'package:flutter/material.dart';
import 'package:to_ryu_mon_2024/greetings.dart';
import 'package:to_ryu_mon_2024/page/start_page.dart';
import 'package:to_ryu_mon_2024/share/share.dart';
import 'package:to_ryu_mon_2024/stroke_page_transition.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResultView extends StatelessWidget {
  final VoidCallback onRestart;
  final int score;
  const ResultView({super.key, required this.onRestart, required this.score});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("SCORE",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            Text("$score",
                style: const TextStyle(fontSize: 100, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                  "${getGreetingFromScore(score)}\n2024年 元旦 fastriver_org",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            ),
            TextButton(
              onPressed: onRestart,
              child: const Text('Restart',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                navigateWithStrokeTransition(context, const StartPage());
              },
              child: const Text('Home',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                showShareDialog(context, "登竜門2024 - SCORE: $score");
              },
              child: const Text('Share',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            if (score >= 1000)
              TextButton(
                onPressed: () async {
                  await launchUrlString("https://photos.app.goo.gl/aCKwYcJGup36gwDYA");
                },
                child: const Text('New Year\'s Gift',
                    style: TextStyle(fontSize: 30, color: Colors.white)),)
          ],
        ),
      ),
    );
  }
}
