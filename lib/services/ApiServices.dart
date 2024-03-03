import 'dart:convert';

import 'package:newsify/models/ArticleModel.dart';
import 'package:http/http.dart';


class ApiService {
  final endPointUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ec3b0a4dd48042e68ab4264485bb4a6a";

  Future<List<Article>> getArticle() async {
    Uri url = Uri.parse(endPointUrl);
    Response res = await get(url);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}