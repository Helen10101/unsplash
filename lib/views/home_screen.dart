import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  List<String> ImgUrl = [];
  List<String> author = [];
  bool showImg = false;

  fetchData() async {
    var response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9'));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      _findPhoto();
      _findAuthor();
      setState(() => showImg = true);
    } else {
      print('Error with json');
    }
  }

  _findPhoto() async {
    for (var i = 0; i < data.length; i++) {
      ImgUrl.add(data.elementAt(i)["urls"]["regular"]);
    }
  }

  _findAuthor() async {
    for (var i = 0; i < data.length; i++) {
      author.add(data.elementAt(i)["user"]["name"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    imgUrl: ImgUrl.elementAt(index),
                    author: author.elementAt(index),
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  child: !showImg
                      ? const Center(
                          child: SpinKitRotatingCircle(
                            color: Colors.red,
                            size: 50,
                          ),
                        )
                      : Image(
                          image: NetworkImage(ImgUrl.elementAt(index)),
                        ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 10.0, right: 10.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    color: Colors.black54.withOpacity(0.6),
                    child: !showImg
                        ? const Center(
                            child: SpinKitRotatingCircle(
                              color: Colors.red,
                              size: 50,
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              text: 'by ',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: author.elementAt(index),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        mainAxisSpacing: 17.0,
        crossAxisSpacing: 17.0,
      ),
    );
  }
}
