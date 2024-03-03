import 'package:flutter/material.dart';
import 'package:newsify/models/CommentModel.dart';

class CommentTile extends StatefulWidget {
  final Map<String, dynamic> comment;
  const CommentTile({super.key, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
      // add web view code.
        },
      child: Container(
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.person)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comment['userId'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  widget.comment['comment'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ],
        )
      )
    );
  }
}
