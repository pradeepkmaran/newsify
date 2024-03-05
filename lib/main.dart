import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/FirestoreServices.dart';

import 'package:newsify/screens/auth/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreServices firestoreServices = FirestoreServices();
  Timer.periodic(new Duration(seconds: 3600), (timer) {
    firestoreServices.fetchAndAddNews();
  });
  FirestoreServices _firestoreservices = FirestoreServices();
  _firestoreservices.ensureCommentsCollectionAndArticleIdField();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Newsify",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return HomePage(category: "general",);
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return LoginPage();
          },
        ),
      )
  );
}
