import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsify/components/CommentTile.dart';
import 'package:newsify/services/firestoreServices.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsify/components/CommentTile.dart';
import 'package:newsify/services/firestoreServices.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentBox extends StatefulWidget {
  final String articleId;
  const CommentBox({Key? key, required this.articleId}) : super(key: key);

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final firestoreServices = FirestoreServices();
  late List<Map<String, dynamic>> comments;
  final commentController = TextEditingController();

  Future<String> getUsername() async {
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
      Map<String, dynamic> user = userDoc.data() as Map<String, dynamic>;
      return user['username'];
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    comments = await firestoreServices.fetchCommentsFromDB(widget.articleId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body:
      // Text("HI"),
      FutureBuilder(
          future: firestoreServices.fetchCommentsFromDB(widget.articleId),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data!.length > 1) {
              List<Map<String, dynamic>>? comments = snapshot.data;
              return ListView.builder(
                itemCount: comments?.length,
                itemBuilder: (context, index) => CommentTile(comment: comments![index],),
              );
            } else {
              return Center(
                child: Text('No comments available'),
              );
            }
          },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Write your comment...',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if(commentController.text.isNotEmpty){
                  String username = await getUsername();
                  await firestoreServices.addCommentsToDB(username, widget.articleId, commentController.text);
                  _refreshData();
                  setState(() {
                    commentController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
