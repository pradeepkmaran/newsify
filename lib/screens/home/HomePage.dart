import 'package:flutter/material.dart';
import 'package:newsify/models/ArticleModel.dart';
import 'package:newsify/screens/drawer/Drawer.dart';
import 'package:newsify/services/ApiServices.dart';
import 'package:newsify/components/CustomListTile.dart';
import 'package:newsify/services/firestoreServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  FirestoreServices firestoreServices = FirestoreServices();

  Future<void> _refreshData() async {
    await firestoreServices.fetchAndAddNews();
    await firestoreServices.fetchNewsFromDB();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawBar(),
      appBar: AppBar(
        title: Text("Newsify"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: firestoreServices.fetchNewsFromDB(),
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
    );
  }
}
