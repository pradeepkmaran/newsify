import 'package:flutter/material.dart';

import 'LoginPage.dart';

void main() {
  runApp(MaterialApp(home: LoginPage(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
