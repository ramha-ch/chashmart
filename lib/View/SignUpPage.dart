import 'dart:math';
import 'package:chashmart/Home/DashBoardPage.dart';
import 'package:chashmart/Home/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'SignInGoogle.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Customers");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  final _formKey = GlobalKey<FormState>();

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
                          'Create your Account',
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
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.grey.shade200.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _nameController,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF183765),
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  hintText: 'John Adam',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter you name';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.grey.shade200.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _emailController,
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
                                  if (value!.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.grey.shade200.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _passwordController,
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
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                  try {
                    // Create the user in Firebase Authentication
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.value.text,
                      password: _passwordController.value.text,
                    );

                    // Get the newly created user's ID
                    var userID = userCredential.user!.uid;

                    // Store additional user data in Firestore
                    await FirebaseFirestore.instance.collection('Customers').doc(userID).set({
                      "id": userID,
                      "name": _nameController.value.text,
                      "email": _emailController.value.text,
                      // Don't store the password in Firestore for security reasons
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard(userID: userID)),
                    );
                  } catch (error) {
                    // Handle any errors that occurred during user creation or Firestore write
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  }
                }
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
                    SizedBox(height: 50),
                    Text("- Or sign in with -"),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            GoogleSignUpHelper googleSignUpHelper = GoogleSignUpHelper();
                            UserCredential? userCredential = await googleSignUpHelper.signUpWithGoogle();
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
                            primary: Colors.transparent, // Set background color to transparent
                            shadowColor: Colors.white, // Remove shadow
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          icon: Image.asset(
                            'assets/View/facebook.PNG',
                            height: 50,
                            width: 50,
                          ),
                          label: Text(''), // Set an empty label to hide text
                        ),
                        SizedBox(width: 14),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Add onPressed logic for Twitter sign-in
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Set your desired background color here// Remove shadow
                            padding: EdgeInsets.zero, // Set your desired background color here
                          ),
                          icon: Image.asset('assets/View/twitter.PNG',
                              height: 50, width: 50),
                          label: Text(''),
                        ),
                      ],
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


