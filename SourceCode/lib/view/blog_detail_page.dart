import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/blog_model.dart';

class BlogDetail extends StatefulWidget
{
  final Blog blog;
  const BlogDetail({required this.blog,Key? key}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail>
{

  bool isFavorite = false;
  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    Fluttertoast.showToast(
      msg: isFavorite ? "Marked as Favorite" : "Removed from Favorites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF091945),
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Color(0xFF25262d),size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
        title: const Text("Blog Details",style:
        TextStyle(fontSize: 20.0,color: Color(0xFF091945),fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? const Color(0xFF091945) : const Color(0xFF40cde8), // Customize colors as needed
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: size.height*0.35,
                  width: size.width*0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.blog.imageUrl),

                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02),
              Text(widget.blog.title,style: const TextStyle(fontFamily: 'ProductSans',fontSize: 20,color: Color(0xFF25262d),fontWeight: FontWeight.bold)),
              SizedBox(height: size.height*0.03),
              const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede.',
                style: TextStyle(fontFamily: 'ProductSans',fontSize: 15,color: Colors.grey),textAlign: TextAlign.justify,),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text('Author : ',style: TextStyle(fontFamily: 'ProductSans',fontSize: 16,color: Color(0xFF40cde8))),
                  Text('Sierra Mike',style: TextStyle(fontFamily: 'ProductSans',fontSize: 16,color: const Color(0xFF25262d).withOpacity(0.8))),
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
