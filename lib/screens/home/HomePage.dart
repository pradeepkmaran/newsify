import 'package:flutter/material.dart';
import 'package:newsify/screens/drawer/Drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawBar(),
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
    );
  }
}
