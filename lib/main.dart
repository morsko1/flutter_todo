import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/main_page.dart';

void main() {
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
