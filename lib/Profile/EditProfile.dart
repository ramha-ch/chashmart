import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final String userID;

  EditProfilePage({required this.userID});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _name = '';
  String _email = '';
  String _password = '';
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('Customers').doc(widget.userID).get();
      print("Fetched user data: ${userSnapshot.data()}"); // Debug print
      setState(() {
        _name = userSnapshot.get('name') ?? '';
        _email = userSnapshot.get('email') ?? ''; // Update _email state
      });
      print("Name: $_name, Email: $_email"); // Debug print
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [

            SizedBox(height: 156),
            Image.asset(
              'assets/home/update.gif',
              width: 300,
              height: 300,
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
                 child:  TextFormField(
                   style: const TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                     color: Color(0xFF183765),
                   ),
                   decoration: const InputDecoration(
                     labelText: 'Name',

                     border: InputBorder.none,
                   ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    initialValue: _name,
                  ),

                ),
              ),

            SizedBox(height: 16),
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

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183765),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email',

                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  initialValue: _email,
                ),

              ),
            ),

            SizedBox(height: 16),
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
                child:   TextFormField(
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183765),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Password',

                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  obscureText: true,
                ),

              ),
            ),




            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // Here you can update the profile data in Firestore
                await FirebaseFirestore.instance.collection('Customers').doc(widget.userID).update({
                  'name': _name,
                  'email': _email, // Update email
                  // You may need to handle password updates securely
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF183765),
                minimumSize: Size(330, 55),
              ),
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}


