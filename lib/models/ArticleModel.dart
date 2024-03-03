//Now let's create the article model
// for that we just need to copy the property from the json structure
// and make a dart object

import 'SourceModel.dart';

class Article {
  String uuid;
  String title;
  String description;
  String keywords;
  String snippet;
  String url;
  String imageUrl;
  String language;
  String publishedAt;
  String source;
  String categories;

  //Now let's create the constructor
  Article({required this.uuid,
    required this.title,
    required this.description,
    required this.keywords,
    required this.snippet,
    required this.url,
    required this.imageUrl,
    required this.language,
    required this.publishedAt,
    required this.source,
    required this.categories,
  });

  //And now let's create the function that will map the json into a list
  factory Article.fromJson(Map<String, dynamic> json) {
    Article article = Article(
          uuid: json['uuid'],
          title: json['title'],
          description: json['description'],
          keywords: json['keywords'],
          snippet: json['snippet'],
          url: json['url'],
          imageUrl: json['image_url'],
          language: json['language'],
          publishedAt: json['published_at'],
          source: json['source'],
          categories: json['categories'],
    );
    return article;
  }
}