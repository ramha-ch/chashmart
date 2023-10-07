
import 'package:flutter/material.dart';
import 'dart:async';


class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _currentIndex = 0;
  List<String> imageList = [
    "assets/aboutUs/test.gif",
    "assets/aboutUs/face.gif",
    "assets/aboutUs/eye.gif",
  ];

  List<String> imageCaptions = [
    'Provide Customers 3D TRY ON and they can explore various  styles, colors, and sizes of glasses, making it  easier for them to make confident and informed purchase decisions.',
    'Suggest the glasses frames that suit best according to the user\'s face shape by developing an AI algorithm that detects and recognizes the user\'s face shape and suggests glasses suitable fro their face.',
    'Basic vision testing that allows users to do basic vision acuity tests,that help users identify vision impairments and determine if they should visit a doctor based on their test scores.',
    ];

  List<String> headings = [
    '3D Try-ON ',
    'Recommendation System ',
    'Basic Vision Test',
  ];


  void _changeImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imageList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      _changeImage();
    });
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageList.map((url) {
        int index = imageList.indexOf(url);
        return Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 230),
          SizedBox(
            height: 200,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                imageList[_currentIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
      Container(
            child: Text(
              headings[_currentIndex],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              imageCaptions[_currentIndex],
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 170),
          _buildDots(), // Add the dots at the bottom
        ],
      ),
    );
  }
}
