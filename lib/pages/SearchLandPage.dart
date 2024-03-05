import 'package:flutter/material.dart';
import 'package:newsify/components/CustomListTile.dart';
import 'package:newsify/screens/drawer/Drawer.dart';
import 'package:newsify/services/FirestoreServices.dart';

class SearchLandPage extends StatefulWidget {
  final String searchKey;
  const SearchLandPage({super.key, required this.searchKey});

  @override
  State<SearchLandPage> createState() => _SearchLandPageState();
}

class _SearchLandPageState extends State<SearchLandPage> {

  FirestoreServices firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawBar(),
      appBar: AppBar(
        title: Text(
          "Newsify",
          style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: firestoreServices.fetchSearchNews(widget.searchKey),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                List<Map<String, dynamic>>? articles = snapshot.data;
                return ListView.builder(
                  itemCount: articles?.length,
                  itemBuilder: (context, index) => CustomListTile(article: articles![index], context: context),
                );
              } else {
                return Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
