import 'package:flutter/material.dart';
import 'package:toonflix/screen/home_screen.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
