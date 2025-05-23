import 'package:flutter/material.dart';
import 'screens/search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
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
}



final String? token = dotenv.env['QIITA_ACCESS_TOKEN']; // .env に記述したアクセストークンを取得