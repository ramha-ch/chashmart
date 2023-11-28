import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String _name;
  late String _email;
  late String _password = ''; // Initialize _password to an empty string
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String currentUserId = currentUser!.uid;
        DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('Customers').doc(currentUserId).get();

        print("Fetched user data: ${userSnapshot.data()}");
        setState(() {
          _name = userSnapshot.get('name') ?? '';
          _email = userSnapshot.get('email') ?? '';
        });

        print("Name: $_name, Email: $_email");
      } else {
        print('No current user found');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> updateUserDataInFirebaseAuth() async {
    try {
      if (_email.isNotEmpty) {
        await currentUser?.updateEmail(_email);
      }

      if (_password.isNotEmpty) {
        await currentUser?.updatePassword(_password);
      }
    } catch (error) {
      print('Error updating user data in Firebase Auth: $error');
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
            buildTextField('Name', _name, (value) {
              setState(() {
                _name = value;
              });
            }),
            SizedBox(height: 16),
            buildTextField('Email', _email, (value) {
              setState(() {
                _email = value;
              });
            }),
            SizedBox(height: 16),
            buildTextField('Password', _password, (value) {
              setState(() {
                _password = value;
              });
            }, isPassword: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateUserDataInFirebaseAuth();

                await FirebaseFirestore.instance.collection('Customers').doc(currentUser?.uid).update({
                  'name': _name,
                  'email': _email,
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

  Widget buildTextField(String labelText, String initialValue, ValueChanged<String> onChanged,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.5),
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
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          initialValue: initialValue,
          obscureText: isPassword,
        ),
      ),
    );
  }
}
