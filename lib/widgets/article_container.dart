import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleContainer extends StatelessWidget{
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:20,
        vertical: 16,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('yyyy/MM/dd').format(article.createdAt),
              style: const TextStyle(
                color:Colors.white,
                fontSize:12,
              ),
            ),
            Text(
              article.title,
              maxLines:2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize:16,
                fontWeight: FontWeight.bold,
                color:Colors.white,
              ),
            ),
            Text(
              '#${article.tags.join('#')}',
              style: const TextStyle(
                fontSize:12,
                color:Colors.white,
                fontSize
              )

            ),
          ],
        ),
      ),
    );
  }

}