import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_first/models/article.dart';
import '../screens/article_screen.dart';

class ArticleContainer extends StatefulWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<ArticleContainer> createState() => _ArticleContainerState();
}

class _ArticleContainerState extends State<ArticleContainer> {
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.article.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticleScreen(article: widget.article),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF70D9DC),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 投稿日
              Text(
                DateFormat('yyyy/MM/dd').format(widget.article.createdAt),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),

              // タイトル
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

              // タグ
              Text(
                '#${widget.article.tags.join(' #')}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),

              // ハート＋投稿者情報
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ハートといいね数
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

                  // 投稿者
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
            ],
          ),
        ),
      ),
    );
  }
}
