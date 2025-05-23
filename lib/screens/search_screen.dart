import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first/models/article.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qitta Search'),
      ),
      body: Container(),
    );
  }
}

Future<List<Article>> searchQuiita(String keyword) async{
  final uri = Uri.https('quiita.com','/api/v2/items',{
    'query' : 'title:$keyword',
    'per_page' : '10',
  });
  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
  final http.Response res = await http.get(uri, headers:{
    'Authorization':'Bearer $token',

  });

  if (res.StatusCode == 200){
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  }else{
    return[];
  }
}
