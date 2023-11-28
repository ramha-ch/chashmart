import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _commentController = TextEditingController();
  double _userRating = 0;

  List<String> chasmartLetters = ['C', 'CH', 'CHA', 'CHAS', 'CHASH', 'CHASHM', 'CHASHMA', 'CHASMAR', 'CHASMART'];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startDisplay();
  }
  void _startDisplay() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (currentIndex < chasmartLetters.length - 1) {
        setState(() {
          currentIndex++;
        });
        _startDisplay();
      }
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _submitReview(String review, double rating) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('Customers')
            .doc(currentUser.uid)
            .collection('reviews')
            .add({
          'review': review,
          'rating': rating,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _showDialog('Review Submitted', 'Thank you for submitting your review!');
      } else {
        _showDialog('Error', 'There was an error submitting your review. Please try again later. User is null.');
      }
    } catch (error) {
      print('Error submitting review: $error');
      _showDialog('Error', 'There was an error submitting your review. Please try again later.');
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('There was an error submitting your review. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            Text(
              chasmartLetters[currentIndex],
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183765),
              ),
            ),
            Container(
              height: 270,
              width: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/rate.PNG'),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'How would you Rate our App Experience?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _userRating = i.toDouble();
                        });
                      },
                      child: Icon(
                        Icons.star,
                        color: i <= _userRating ? Color(0xFF183765) : Colors.grey,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Share your thoughts',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _commentController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Any Suggestions.....',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_userRating > 0) {
                  _submitReview(
                    _commentController.text,
                    _userRating,
                  );
                } else {
                  _showRatingErrorDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF183765),
                minimumSize: Size(100, 50),
              ),
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rating Error'),
          content: Text('Please select a rating before submitting.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
