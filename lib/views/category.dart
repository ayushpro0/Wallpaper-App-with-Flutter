import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/widget/widget.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {

  final String categoryName;
  Categorie({required this.categoryName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async {
    var url = Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=30&page=1');
    var response = await http.get(url, headers: {"Authorization": apiKey});
    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel;
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpapers(widget.categoryName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: brandName(),
        elevation: 0.0,

      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              wallpaperList(wallpapers: wallpapers, context: context),
            ],),),
      ),
    );
  }
}
