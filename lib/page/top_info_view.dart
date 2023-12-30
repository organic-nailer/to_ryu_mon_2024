import 'package:flutter/material.dart';
import 'package:to_ryu_mon_2024/fish.dart';

class TopInfoView extends StatelessWidget {
  final int score;
  final Fish fish;
  const TopInfoView({super.key, required this.score, required this.fish});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.biggest.width;
      return Container(
          color: const Color(0xFF7ACDFF),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: width * 0.2,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.03),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("SCORE",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: width * 0.03)),
                            Text("$score",
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: width * 0.05)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: width * 0.2,
                      child: Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Padding(
                        padding: EdgeInsets.all(width * 0.03),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/${fish.img}"),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(fish.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge?.copyWith(fontSize: width * 0.03)),
                                    Text(fish.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall?.copyWith(fontSize: width * 0.025)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                        padding: EdgeInsets.all(width * 0.03),
                  child: Text("コイをタップして龍の発生を阻止しよう！コイ以外の阻止は良くない",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: width * 0.025)),
                ),
              )
            ],
          ));
    });
  }
}