import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUsername(String uid, String username) async {
    await _firestore.collection('users').add({"uid": uid, "username": username});
  }

  Future<void> fetchAndAddNews() async {
    try {
      Uri url = Uri.parse(
          'https://api.thenewsapi.com/v1/news/all?api_token=RPiJb7Ez2co0n7zVEmHP4QPdLMVKT0fte9xIsFKk&language=en&limit=3');
      Response response = await get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> articles = jsonData['data'];

        for (var article in articles) {
          String uniqueIdentifier = article['uuid'];
          if (_isValidArticle(article)) {
            DocumentReference docRef =
            _firestore.collection('news').doc(uniqueIdentifier);
            DocumentSnapshot docSnapshot = await docRef.get();

            if (!docSnapshot.exists) {
              await docRef.set({
                'title': article['title'],
                'description': article['description'],
                'keywords': article['keywords'],
                'snippet': article['snippet'],
                'url': article['url'],
                'imageUrl': article['image_url'],
                'language': article['language'],
                'publishedAt': article['published_at'],
                'source': article['source'],
                'categories': article['categories'],
                'created': Timestamp.now(),
              }, SetOptions(merge: true));
              print('Added new article: $uniqueIdentifier');
            } else {
              print('Article already exists: $uniqueIdentifier');
            }
          }
          else{
            print("Article $uniqueIdentifier} not in good condition");
          }
        }
      } else {
        print("Failed to fetch articles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print('Error fetching and adding news: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchNewsFromDB() async {
    try {
      List<Map<String, dynamic>> articles = [];
      QuerySnapshot querySnapshot = await _firestore
          .collection('news')
          .orderBy("created", descending: true)
          .get();
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (_isValidArticleData(data)) {
          articles.add(data);
        }
      });
      return articles;
    } catch (error) {
      print('Error fetching articles from Firestore: $error');
      return [];
    }
  }

  bool _isValidArticle(Map<String, dynamic> article) {
    return article['imageUrl'] != "" &&
        article['title'] != "" &&
        article['url'] != "" &&
        article['description'] != "" &&
        article['source']!="" &&
        !_containsInvalidSequence(article['title']) &&
        !_containsInvalidSequence(article['description']);
  }

  bool _containsInvalidSequence(String input) {
    return input.contains('â') || input.contains('') || input.contains('');
  }

  bool _isValidArticleData(Map<String, dynamic> data) {
    return NetworkImage(data['imageUrl']) != null &&
        data['source'] != "" &&
        data['imageUrl'] != "" &&
        data['title'] != "" &&
        data['url'] != "";
  }

  Future<int> isValidUsername(String username) async {
    try {
      QuerySnapshot results = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)// Limit to 1 document, as we only want to check if any matching document exists
          .get();
      if(results.docs.isNotEmpty) return 0; // Enter unique username
      RegExp regex = RegExp(r'^[a-zA-Z0-9._]+$', unicode: true);
      if(regex.hasMatch(username)){
        return 1;
      }
      return -1;
    } catch (error) {
      print('Error checking field with value: $error');
      return 0; // Return false in case of any error or exception
    }
  }
}
