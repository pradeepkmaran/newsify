import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsify/models/ArticleModel.dart';
import 'package:newsify/pages/ArticleDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:newsify/screens/drawer/Comments.dart';
import 'package:newsify/services/firestoreServices.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomListTile extends StatefulWidget {
  final Map<String, dynamic> article;
  final BuildContext context;
  const CustomListTile({super.key, required this.article, required this.context});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  FirestoreServices _firestoreServices = FirestoreServices();

  Future<String> getUserId() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    return userUid;
  }

  bool isLiked = false;

  Future<void> _checkLiked() async {
    isLiked =  await _firestoreServices.checkLiked(widget.article['articleId'], await getUserId());
    if(isLiked){
      print("Liked");
    }
    else print("Not liked");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLiked();
  }

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(widget.article['imageUrl']), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    FirestoreServices _fireStore = FirestoreServices();
                    _fireStore.updateLikesInNews(widget.article['articleId'], isLiked, await getUserId());
                  },
                  icon: isLiked
                      ? Icon(Icons.favorite, color: Colors.red, size: 30,)
                      : Icon(Icons.favorite_border, size: 30),
                ),

                IconButton(onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentBox(articleId: widget.article['articleId'])));
                }, icon: Icon(Icons.chat, size: 30,)),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.article['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              widget.article['source'],
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
}
