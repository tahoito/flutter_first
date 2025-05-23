import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first/models/article.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
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
        children: [
          // 検索ボックス
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
                border: OutlineInputBorder(), // ← 見た目の枠を追加
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value);
                setState(() => articles = results);
              },
            ),
          ),

          // 検索結果一覧
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.user.id),
                  onTap: () {
                    // 後でURL遷移も追加できる！
                  },
                );
              },
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
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}
