import 'package:flutter/material.dart';
import 'package:newsify/models/ArticleModel.dart';
import 'package:newsify/pages/SearchLandPage.dart';
import 'package:newsify/screens/drawer/Drawer.dart';
import 'package:newsify/services/ApiServices.dart';
import 'package:newsify/components/CustomListTile.dart';
import 'package:newsify/components/CommentTile.dart';
import 'package:newsify/services/FirestoreServices.dart';
import 'package:newsify/models/CategoryModel.dart';
import 'package:newsify/pages/Categories.dart';
import 'package:newsify/screens/home/CategoryCard.dart';

class HomePage extends StatefulWidget {
  final String category;
  const HomePage({Key? key, required this.category}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  FirestoreServices firestoreServices = FirestoreServices();
  TextEditingController searchController = TextEditingController();
  List<CategoryModel> myCategories = List<CategoryModel>.generate(0, (index) => CategoryModel());

  @override
  void initState() {
    super.initState();
    myCategories = getCategories();
    print(widget.category);
  }

  Future<void> _refreshData() async {
    await firestoreServices.fetchAndAddNews();
    await firestoreServices.fetchNewsFromDB();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(category: widget.category,)));
  }

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if(searchController.text.isNotEmpty){
                          String searchKey = searchController.text;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchLandPage(searchKey: searchKey)));
                          setState(() {
                            searchController.clear();
                          });
                        }
                      },
                      icon: Icon(Icons.search), // Customize the icon as needed
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 5.0, 0, 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: myCategories.map((category) {
                      return CategoryCard(
                        imageAssetUrl: category.imageAssetUrl,
                        categoryName: category.categoryName,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: FutureBuilder(
                    future: firestoreServices.fetchCategoryNewsFromDB(widget.category),
                    //future: firestoreServices.fetchNewsFromDB(),
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
            ],
          ),
        ),
      ),
    );
  }
}
