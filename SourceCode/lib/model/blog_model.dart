import 'dart:convert';

BlogModelList blogModelFromJson(String str) => BlogModelList.fromJson(json.decode(str));
class BlogModelList {
  List<Blog> blogs;

  BlogModelList({
    required this.blogs,
  });

  factory BlogModelList.fromJson(Map<String, dynamic> json) => BlogModelList(
    blogs: List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
  );

}

class Blog {
  String id;
  String imageUrl;
  String title;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    imageUrl: json["image_url"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "title": title,
  };
}
