class Comment {
  String uuid;
  String userId;
  String comment;
  int likes = 0;
  Comment({required this.uuid,
    required this.userId,
    required this.comment
  });

  //And now let's create the function that will map the json into a list
  factory Comment.fromJson(Map<String, dynamic> json) {
    Comment cmnt = Comment(
      uuid: json['uuid'],
      userId: json['userId'],
      comment: json['comment'],
    );
    return cmnt;
  }
}