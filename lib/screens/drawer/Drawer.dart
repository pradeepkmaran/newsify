import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsify/screens/auth/LoginPage.dart';
import 'package:newsify/services/AuthServices.dart';
import 'package:newsify/pages/SavedArticlesPage.dart';

class DrawBar extends StatefulWidget {
  const DrawBar({super.key});

  @override
  State<DrawBar> createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedArticles()));
              },
                  icon: Icon(Icons.bookmark),
                  label: Text("Saved Articles")),
              new Spacer(),
              ElevatedButton.icon(onPressed: () async {
                await authService.userSignOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, icon: Icon(Icons.exit_to_app), label: Text("Sign Out"))
            ],
          ),
        ),
      )
    );
  }
}
