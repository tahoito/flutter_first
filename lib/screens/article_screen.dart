import 'package:flutter/material.dart';
import 'package:flutter_first/models/article.dart';
import 'package:intl/intl.dart';
class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, required this.article});

  final Article article;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.article.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEFFFEF), // 背景色も変えられる
        appBar: AppBar( // ← 戻るボタン付きAppBar
          title: const Text("記事詳細"),
          backgroundColor: const Color(0xFF70D9DC),
          foregroundColor: Colors.white, // 戻るボタンやタイトルの色
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF55C500),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy/MM/dd').format(widget.article.createdAt),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '#${widget.article.tags.join(' #')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                              likes++;
                              });
                            },
                          ),
                          Text(
                            likes.toString(),
                            style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage:
                            NetworkImage(widget.article.user.profileImageUrl),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.article.user.id,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 300), // ← スクロール確認用のスペース
                ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}