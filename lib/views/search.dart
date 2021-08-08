import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {

  final  String searchQuery;
  Search({required this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();
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
    getSearchWallpapers(widget.searchQuery);

    super.initState();
    searchController.text = widget.searchQuery;
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
                          border: InputBorder.none,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchWallpapers(searchController.text);
                      },
                      child: Container(child: Icon(Icons.search_rounded, size: 25,),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              wallpaperList(wallpapers: wallpapers, context: context),
            ],),),
      ),
    );
  }
}
