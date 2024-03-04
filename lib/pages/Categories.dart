import 'package:newsify/models/CategoryModel.dart';


List<CategoryModel> getCategories(){

  List<CategoryModel> myCategories = List<CategoryModel>.generate(0, (index) => CategoryModel());
  CategoryModel categoryModel;

  //1 (general)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "general";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bmV3c3xlbnwwfHwwfHx8MA%3D%3D";
  myCategories.add(categoryModel);

  //2 (science)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "science";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1564325724739-bae0bd08762c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2NpZW5jZXxlbnwwfHwwfHx8MA%3D%3D";
  myCategories.add(categoryModel);

  //3 (sports)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "sports";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1459865264687-595d652de67e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c3BvcnRzfGVufDB8fDB8fHww";
  myCategories.add(categoryModel);

  //4 (business)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "business";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  myCategories.add(categoryModel);

  //5 (health)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "health";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1477332552946-cfb384aeaf1c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aGVhbHRofGVufDB8fDB8fHww";
  myCategories.add(categoryModel);

  //6 (entertainment)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "entertainment";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1603190287605-e6ade32fa852?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZW50ZXJ0YWlubWVudHxlbnwwfHwwfHx8MA%3D%3D";
  myCategories.add(categoryModel);

  //7 (tech)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "tech";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D";
  myCategories.add(categoryModel);

  //8 (politics)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "politics";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1520452112805-c6692c840af0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9saXRpY3N8ZW58MHx8MHx8fDA%3D";
  myCategories.add(categoryModel);

  //9 (food)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "food";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGZvb2R8ZW58MHx8MHx8fDA%3D";
  myCategories.add(categoryModel);

  //10 (travel)
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "travel";
  categoryModel.imageAssetUrl = "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmVsfGVufDB8fDB8fHww";
  myCategories.add(categoryModel);




  return myCategories;

}