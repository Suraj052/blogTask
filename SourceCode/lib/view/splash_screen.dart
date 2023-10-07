import 'dart:async';
import 'package:blog/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()
        )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
          child:Text('Blog Explorer',
            style: TextStyle(fontFamily: 'ProductSans',fontSize: 20,color: Color(0xFF091945),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        )
    );
  }
}