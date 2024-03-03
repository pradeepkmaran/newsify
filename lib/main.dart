import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsify/screens/home/HomePage.dart';
import 'package:newsify/services/firestoreServices.dart';

import 'package:newsify/screens/auth/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreServices firestoreServices = FirestoreServices();
  Timer.periodic(new Duration(seconds: 3600), (timer) {
    firestoreServices.fetchAndAddNews();
  });
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Newsify",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return HomePage();
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
