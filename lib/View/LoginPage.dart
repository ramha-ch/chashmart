import 'package:chashmart/Home/DashBoardPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chashmart/Home/AboutUsPage.dart';
import 'package:chashmart/Home/ProfilePage.dart';
import 'package:chashmart/View/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:chashmart/View/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'SignInGoogle.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _formKey = GlobalKey<FormState>();


class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> _loginWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (userCredential.user != null) {
          // User is logged in, navigate to the dashboard screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                Dashboard(userID: _auth.currentUser!.uid),
          ));
        }
      } catch (e) {
        print('Login Error: $e');
        // Handle login error and show an error message to the user.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your email and password.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90),
              Container(
                height: 200,
                width: 200, // Specify the desired height
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/View/namelogo.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login to your Account',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Form(
                    key:  _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Set the background color of the box
                                border: Border.all(
                                  color: Colors.white,
                                  width:
                                      2.0, // Set the border width to make it bold
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.5),
                                    // Shadow color
                                    spreadRadius: 4,
                                    // Spread radius
                                    blurRadius: 7,
                                    // Blur radius
                                    offset: Offset(0, 3),
                                    // Offset from the top-left of the box
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: emailController,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF183765),
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'xyz@gmail.com',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Set the background color of the box
                                border: Border.all(
                                  color: Colors.white,
                                  width:
                                      2.0, // Set the border width to make it bold
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.5),
                                    // Shadow color
                                    spreadRadius: 4,
                                    // Spread radius
                                    blurRadius: 7,
                                    // Blur radius
                                    offset: Offset(0, 3),
                                    // Offset from the top-left of the box
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF183765),
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: '*********',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () async {
                                await _loginWithEmailAndPassword(context);
                              },

                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF183765),
                              minimumSize: Size(330, 55),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),

                          ),
                          SizedBox(height: 40),
                          Text("- Or sign in with -"),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  GoogleSignUpHelper googleSignUpHelper = GoogleSignUpHelper();
                                  UserCredential? userCredential = await googleSignUpHelper.signUpWithGoogle();

                                  if (userCredential != null) {
                                    // Handle successful sign-up here, e.g., navigate to the next screen.
                                    // You can replace the below code with your navigation logic.
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePageScreen(userID: userCredential.user!.uid),
                                      ),
                                    );
                                  } else {
                                    // Handle sign-up failure here.
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .white, // Set your desired background color here
                                ),
                                icon: Image.asset('assets/View/google.png',
                                    height: 50, width: 50),
                                label: Text(''),
                              ),
                              SizedBox(width: 14),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Add onPressed logic for Facebook sign-in
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .white, // Set your desired background color here
                                ),
                                icon: Image.asset('assets/View/facebook.PNG',
                                    height: 50, width: 50),
                                label: Text(''),
                              ),
                              SizedBox(width: 14),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Add onPressed logic for Twitter sign-in
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .white, // Set your desired background color here
                                ),
                                icon: Image.asset('assets/View/twitter.PNG',
                                    height: 50, width: 50),
                                label: Text(''),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          MaterialButton(onPressed: () {}),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't  have an account"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text("Sign Up"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class GoogleSignUpHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<UserCredential?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );
        return await _auth.signInWithCredential(credential);
      }
    } catch (error) {
      print("Google Sign-Up Error: $error");
    }
    return null;
  }
}
