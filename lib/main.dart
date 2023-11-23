import 'package:flutter/material.dart';
import 'package:projet/tabbar.dart';
// import 'package:projet/views/home.view.dart';
// import 'package:projet/views/home.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Notes', themeMode: ThemeMode.dark, home: Bar());
  }
}
