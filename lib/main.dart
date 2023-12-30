import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_ryu_mon_2024/firebase_options.dart';
import 'package:to_ryu_mon_2024/page/start_page.dart';
import 'package:to_ryu_mon_2024/page/to_ryu_mon_page.dart';

void main() async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAnalytics.instance.logEvent(name: "app_open");

  runApp(const ToRyuMon());
}

class ToRyuMon extends StatelessWidget {
  const ToRyuMon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToRyuMon',
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlue,
        textTheme: GoogleFonts.stickTextTheme(),
      ),
      home: const StartPage(),
      // home: const ToRyuMonPage(),
    );
  }
}
