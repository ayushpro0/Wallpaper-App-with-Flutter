import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/catorgies_model.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/views/search.dart';
import 'package:wallpaper_hub/widget/widget.dart';
import 'package:http/http.dart' as http;

import 'category.dart';
import 'image_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var url = Uri.parse('https://api.pexels.com/v1/curated?per_page=15');
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
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0Xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'search wallpaper',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    )));
                      },
                      child: Container(
                        child: Icon(
                          Icons.search_rounded,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categorieName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),
              SizedBox(height: 16),
              wallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  late final String imgUrl;
  late final String title;

  CategoriesTile({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      categoryName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imgUrl,
                height: 80,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.black26,
                height: 80,
                width: 120,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
