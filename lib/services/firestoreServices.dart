import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{
  Future<void> fetchAndAddNews() async {
    try {
      Uri url = Uri.parse('https://api.thenewsapi.com/v1/news/all?api_token=RPiJb7Ez2co0n7zVEmHP4QPdLMVKT0fte9xIsFKk&language=en&limit=3');
      Response response = await get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<dynamic> articles = jsonData['data'];
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        articles.forEach((article) async {
          if(article['imageUrl']!="" && article['title']!="" && article['url']!="" && isUsableString(article['title']) && isUsableString(article['description'])){
            String uniqueIdentifier = article['uuid'];
            // Explicitly set the document ID using the uuid field
            DocumentReference docRef = firestore.collection('news').doc(uniqueIdentifier);
            DocumentSnapshot docSnapshot = await docRef.get();

            if (!docSnapshot.exists) {
              // Use set() method with merge: true to update existing documents
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
                'created': Timestamp.now()
              }, SetOptions(merge: true));
              print('Added new article: $uniqueIdentifier');
            } else {
              print('Article already exists: $uniqueIdentifier');
            }
          }

        });
      }
      else print("Failed");
    }
    catch (error) {
      print('Error fetching news: $error');
    }
  }
  Future<List<Map<String, dynamic>>> fetchNewsFromDB() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<Map<String, dynamic>> articles = [];
      QuerySnapshot querySnapshot = await firestore
          .collection('news')
          .orderBy("created", descending: true)
          .get();

      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if(data['imageUrl']!="" && data['title']!="" && data['url']!=""){
          articles.add(data);
        }
      });
      return articles;
    } catch (error) {
      print('Error fetching articles: $error');
      return [];
    }
  }
  bool isUsableString(String input) {
    // Define a regular expression pattern to match only alphanumeric characters, spaces, and punctuation marks
    RegExp regex = RegExp(r'^[a-zA-Z0-9.,!? ]+$');

    // Check if the input string matches the regular expression pattern
    return regex.hasMatch(input);
  }
}
