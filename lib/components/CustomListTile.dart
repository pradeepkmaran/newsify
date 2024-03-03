import 'package:newsify/models/ArticleModel.dart';
import 'package:newsify/pages/ArticleDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:newsify/screens/drawer/Comments.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget customListTile(Map<String, dynamic> article, BuildContext context) {
  return InkWell(
    onTap: () async {
      // add web view code.
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              //let's add the height

              image: DecorationImage(
                  image: NetworkImage(article['imageUrl']), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){

              }, icon: Icon(Icons.thumb_up_alt_outlined)),

              IconButton(onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentBox(articleId: article['articleId'])));
              }, icon: Icon(Icons.chat)),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
              article['source'],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          // Text(
          //     article['articleId'] == null? "No id": article['articleId']
          // )
        ],
      ),
    ),
  );
}