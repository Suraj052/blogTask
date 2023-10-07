import 'package:blog/provider/blog_adapter.dart';
import 'package:blog/provider/blog_provider.dart';
import 'package:blog/view/home_page.dart';
import 'package:blog/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'model/blog_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Add Hive adapters for your data model classes, e.g., BlogModel
  Hive.registerAdapter<Blog>(BlogModelAdapter());

  runApp(
    ChangeNotifierProvider(
      create: (context) => BlogProvider(), // Create your ChangeNotifier class here
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

