import 'package:flutter/material.dart';

import 'home_screen.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.imgUrl, required this.author})
      : super(key: key);

  String imgUrl;
  String author;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              circularWidget(),
              circularWidget(),
              circularWidget(),
              circularWidget()
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          textContainer('title:', 'Image from Unspalash'),
          textContainer('author:', widget.author),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 1.5,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Container textContainer(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 20),
          Text(subtitle,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.grey))
        ],
      ),
    );
  }

  Widget circularWidget() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
