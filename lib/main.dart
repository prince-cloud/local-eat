import 'package:flutter/material.dart';
import 'package:local_eat/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Eat',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const MainPage(),
    );
  }
}
