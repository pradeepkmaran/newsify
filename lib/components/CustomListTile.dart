import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsify/models/ArticleModel.dart';
import 'package:newsify/pages/ArticleDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:newsify/screens/drawer/Comments.dart';
import 'package:newsify/services/FirestoreServices.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';


class CustomListTile extends StatefulWidget {
  final Map<String, dynamic> article;
  final BuildContext context;
  const CustomListTile({super.key, required this.article, required this.context});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  FirestoreServices _firestoreServices = FirestoreServices();

  final FlutterTts flutterTts=FlutterTts();
  final TextEditingController textEditingController=TextEditingController();
  bool isLiked = false;
  bool isSaved = false;

  Future<String> getUserId() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    return userUid;
  }

  Future<void> _checkLiked() async {
    bool res = await _firestoreServices.checkLiked(widget.article['articleId'], await getUserId());
    setState(() {
      isLiked = res;
    });
  }
  Future<void> _checkSaved() async {
    bool res = await _firestoreServices.checkSaved(widget.article['articleId'], await getUserId());
    setState(() {
      isSaved = res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLiked();
    _checkSaved();
  }

  @override
  Widget build(BuildContext context) {
    Future _speak(String text) async{
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1.0);
      await flutterTts.setSpeechRate(0.4);
      //print(text);
      //ext="hello world";
      await flutterTts.speak(text);
    }

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

                IconButton(onPressed: (){
                  //print(article.url);
                  Share.share(widget.article['url']);
                }, icon: const Icon(Icons.share, size: 30)),

                IconButton(
                  onPressed: () async {
                    launchUrlString(widget.article['url']);
                  },
                  icon: const Icon(Icons.open_in_new, size: 30),
                ),
                IconButton(onPressed: (){
                  String text=widget.article['description'];
                  print(text);
                  print("inside speak");
                  _speak(text);
                }, icon: Icon(Icons.volume_up)),//opening url
                new Spacer(),
                IconButton(onPressed: () async {
                  setState(() {
                    isSaved = !isSaved;
                  });
                  FirestoreServices _fireStore = FirestoreServices();
                  _fireStore.updateSaved(widget.article['articleId'], isSaved, await getUserId());
                }, icon: isSaved
                    ? Icon(Icons.bookmark, color: Colors.black87, size: 30,)
                    : Icon(Icons.bookmark_outline_sharp, size: 30),)
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
