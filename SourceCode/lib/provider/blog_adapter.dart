import 'dart:convert';

import 'package:hive/hive.dart';

import '../model/blog_model.dart';

class BlogModelAdapter extends TypeAdapter<Blog> {
  @override
  final int typeId = 0; // This is a unique identifier for your model

  @override
  Blog read(BinaryReader reader) {
    return Blog.fromJson(json.decode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Blog obj) {
    writer.write(json.encode(obj.toJson()));
  }
}
