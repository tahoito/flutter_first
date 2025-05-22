import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Search',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Hiragino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: const TextTheme(  // ← constで直接指定する方法に変更
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const SearchScreen(),  // ← こっちを使う前提で修正
    );
  }
}}