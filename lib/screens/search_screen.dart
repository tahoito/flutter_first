import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first/models/article.dart';
import 'package:flutter_first/models/user.dart';
import 'package:flutter_first/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: <Widget>[
      // 検索ボックス
      Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 36,
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          hintText: '検索ワードを入力してください',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        onSubmitted: (value) async {
          final result = await searchQiita(value);
          setState(() => articles = result);
        },
      ),
    ),
    // 検索結果リストを追加
    -         ArticleContainer(
    -           article: Article(
    -             title: 'テスト',
    -             user: User(
    -               id: 'qii-taro',
    -               profileImageUrl: 'https://firebasestorage.googleapis.com/v0/b/gs-expansion-test.appspot.com/o/unknown_person.png?alt=media',
    -             ),
    -             createdAt: DateTime.now(),
    -             tags: ['Flutter', 'dart'],
    -             url: 'https://example.com',
    -           ),
    -         ),
    +          Expanded(
    +            child: ListView(
    +              children: articles
    +                  .map((article) => ArticleContainer(article: article))
    +                  .toList(),
    +            ),
    +          ),
    ],
    ),
    );
  }
}