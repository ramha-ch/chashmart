import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlassDetailsPage extends StatefulWidget {
  final String glassImage;

  GlassDetailsPage({required this.glassImage});

  @override
  _GlassDetailsPageState createState() => _GlassDetailsPageState();
}

class _GlassDetailsPageState extends State<GlassDetailsPage> {
  String selectedColor = 'Black'; // Default color
  int quantity = 1;

  void _addToCart() {
    String userId = 'YOUR_USER_ID';
    FirebaseFirestore.instance.collection('Customers').doc(userId).set({
      'selectedColor': selectedColor,
      'quantity': quantity,
    });

    // Add more data or actions as needed
  }

  Widget _buildColorCircle(String colorName, Color color) {
    bool isSelected = selectedColor == colorName;

    return InkWell(

      onTap: () {
        setState(() {
          selectedColor = colorName;
        });
      },
      child: Container(

        width: 20,
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: isSelected ? Border.all(color: Colors.black, width: 4) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Image.asset(widget.glassImage),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text('Select Color:',  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold,),),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      _buildColorCircle('Black', Colors.black),
                      _buildColorCircle('White', Colors.white),
                      _buildColorCircle('Pink', Colors.pink),
                      _buildColorCircle('Green', Colors.green),
                      _buildColorCircle('Blue', Colors.blue),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text('Quantity:',  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold,),),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Description:',
                style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10),
                  Text(
                    'Elevate your style with our exquisite butterfly glasses collection. Experience fashion-forward eyewear with unmatched quality.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF183765),
                    minimumSize: Size(190, 50),
                  ),
                  child: Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // You can also add a confirmation and payment flow here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF183765),
                    minimumSize: Size(190, 50),
                  ),
                  child: Text('Buy Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
