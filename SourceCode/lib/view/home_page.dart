import 'package:blog/provider/blog_provider.dart';
import 'package:blog/view/blog_detail_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/blog_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final blogProvider = Provider.of<BlogProvider>(context, listen: false);

      // Try to get cached data from Hive
      final cachedBlogs = await blogProvider.getOfflineBlogs();


      if (cachedBlogs?.length == 0) {
        if (await isOnline()) {
          blogProvider.getBlogsList();
        }
      }
    });
  }

  Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.02),
              const Text('Blog Explorer',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF091945),
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.w700)),
              SizedBox(height: size.height*0.01),
              Expanded(
                  child: Consumer<BlogProvider>(
                    builder: (context,value,child) {
                      if (value.isLoading){
                         return const Center(child: CircularProgressIndicator(color: Color(0xFF091945)));
                      }

                      if (value.blogList.isEmpty) {
                        return const Center(child: Text('No data available.'));
                      }

                      return ListView.builder(
                          itemCount: value.blogList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return blogCard(value.blogList[index],size);
                          }
                      );
                    }
                  ),
              ),
            ],
        ),
      ),
    );
  }

  Widget blogCard(Blog blogData,Size size)
  {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BlogDetail(blog: blogData)));
      },
      child: Container(
        height: size.height * 0.34,
        width: size.width * 0.95,
        margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
        padding: const EdgeInsets.symmetric( vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width  * 0.95,
              height: size.height * 0.22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(blogData.imageUrl),
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: size.width*0.85,
                height: size.height*0.05,
                child: Text(blogData.title,overflow: TextOverflow.ellipsis,maxLines: 2,
                    style: const TextStyle(
                        color: Color(0xFF25262D),
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            const Divider(thickness: 1,color: Color(0xFF091945))
          ],
        ),
      ),
    );
  }
}
