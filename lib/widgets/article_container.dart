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
      ),
    );
  }

}