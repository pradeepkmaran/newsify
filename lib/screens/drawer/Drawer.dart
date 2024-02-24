import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsify/services/AuthServices.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(onPressed: () async {
              await authService.userSignOut();
            }, icon: Icon(Icons.exit_to_app), label: Text("Sign Out"))
          ],
        ),
      )
    );
  }
}
