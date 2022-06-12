import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/pages/homepage.dart';
import 'package:local_eat/splashScreen/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startApp() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (firebaseAuth.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            "Local Eat",
          ),
        ),
      ),
    );
  }
}
