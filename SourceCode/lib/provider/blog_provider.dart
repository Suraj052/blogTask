import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:blog/model/blog_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BlogProvider extends ChangeNotifier{

  List<Blog> blogList = [];
  BlogModelList? blogModelList;
  final _urlGetBlogList = "https://intent-kit-16.hasura.app/api/rest/blogs";
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  bool isLoading =  false;

  Future<void> getBlogsList() async {

    isLoading = true;
    notifyListeners();

    try {
      var url = Uri.parse(_urlGetBlogList);

      var response = await http.get(url,
        headers: {
          'x-hasura-admin-secret': adminSecret,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        blogModelList =  BlogModelList.fromJson(jsonResponse);

        blogList = blogModelList?.blogs ?? [];

        final box = await Hive.openBox<List<Blog>>('blogsBox');
        box.put('blogs', blogList);

        log(blogList.toString());

      } else {
        showToast("Something went wrong, Please try after sometime");
      }

    }catch(e){
      log(e.toString());
      showToast("Something went wrong !");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<List<Blog>?> getOfflineBlogs() async {


    isLoading = true;
    notifyListeners();

    final box = await Hive.openBox<List<dynamic>>('blogsBox');
    final cachedBlogs = box.get('blogs', defaultValue: []);

    List<Blog>? blogCacheList = cachedBlogs?.cast<Blog>();

    blogList = blogCacheList ?? [];

    isLoading=false;
    notifyListeners();

    return blogList;
  }

}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: const Color(0xFF091945),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);