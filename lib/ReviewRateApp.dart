import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatefulWidget {
  final String userID;
  ReviewPage({required this.userID});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}


class _ReviewPageState extends State<ReviewPage> {
  final _commentController = TextEditingController();
  double _userRating = 0;

  List<String> chasmartLetters = ['C', 'CH', 'CHA', 'CHAS', 'CHASH', 'CHASHM', 'CHASHMA', 'CHASMAR','CHASMART'];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startDisplay();
  }

  void _startDisplay() {
    Future.delayed(Duration(seconds: 1), () {
      if (currentIndex < chasmartLetters.length - 1) {
        setState(() {
          currentIndex++;
        });
        _startDisplay();
      }
    });
  }

  void _submitReview(String userID, String review, double rating) async {
    try {
      await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userID)
          .collection('reviews')
          .add({
        'review': review,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Review Submitted'),
            content: Text('Thank you for submitting your review!'),
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
    } catch (error) {
      print('Error submitting review: $error');
    }
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
              style: TextStyle(fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183765),),
            ),
            Container(
              height: 270,
              width: 350, // Specify the desired height
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/rate.PNG'),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            // Rating Stars
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
                        color: i <= _userRating ? Color(0xFF183765) : Colors.grey, // Change the star color here
                        size: 40,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            // Comment Box
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
            // ... rest of your UI ...

            ElevatedButton(
              onPressed: () {
                if (_userRating > 0) {
                  _submitReview(
                    widget.userID,
                    _commentController.text,
                    _userRating,
                  );
                } else {
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
}
