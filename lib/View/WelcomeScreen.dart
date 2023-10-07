import 'dart:ui';
import 'package:chashmart/Home/AboutUsPage.dart';
import 'package:chashmart/Home/DashBoardPage.dart';
import 'package:chashmart/View/LoginPage.dart';

import 'package:chashmart/Home/ReviewRateApp.dart';
import 'package:chashmart/View/SignUpPage.dart';
import 'package:flutter/material.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF183765),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            SizedBox(height: 140),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 , ),
                child: Image.asset(
                  'assets/logo.ico',
                  width: 300,
                  height: 300,
                ),
              ),
            ),

            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.blue,

                fixedSize: Size(200, 50),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFF183765),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );

              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF183765),
                fixedSize: Size(200, 50),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
}
