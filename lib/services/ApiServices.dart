import 'dart:convert';

import 'package:newsify/models/ArticleModel.dart';
import 'package:http/http.dart';


class ApiService {
  final endPointUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ec3b0a4dd48042e68ab4264485bb4a6a";

  //Now let's create the http request function
  // but first let's import the http package

  Future<List<Article>> getArticle() async {
    Uri url = Uri.parse(endPointUrl);
    Response res = await get(url);

    //first of all let's check that we got a 200 status code: this mean that the request was a success
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}