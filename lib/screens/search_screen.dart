import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first/models/article.dart';
import 'package:flutter_first/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> articles = [];
  bool isLoading = false;

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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
            child: TextField(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                setState(() => isLoading = true);
                final result = await searchQiita(value);
                setState(() {
                  articles = result;
                  isLoading = false;
                });
              },
            ),
          ),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          // 検索結果リスト
          if (!isLoading)
            Expanded(
              child: ListView(
                children: articles
                    .map((article) => ArticleContainer(article: article))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

Future<List<Article>> searchQiita(String keyword) async {
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
  });

  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  if (res.statusCode == 200) {
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}
