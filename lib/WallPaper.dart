import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'FullScreen.dart';

class WallpaperImage extends StatefulWidget {
  @override
  State<WallpaperImage> createState() => _WallpaperImageState();
}

class _WallpaperImageState extends State<WallpaperImage> {

  List images=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetchApi();
  }
  fetchApi() async{
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {'Authorization': 'gTviesKY5bnSQZ1KiPmg2WxqOjhxnx3vUAJwvMrlSypVc3Y2ru9dzcVC'}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(imagee: images[index]['src']['large2x'])));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]['src']['large'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
         /* InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text('Load More',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
