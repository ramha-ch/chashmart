import 'package:chashmart/Glasses/BG1Page.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ButterFlyGlassesScreen extends StatefulWidget {
  const ButterFlyGlassesScreen({super.key});

  @override
  State<ButterFlyGlassesScreen> createState() => _ButterFlyGlassesScreenState();
}

class _ButterFlyGlassesScreenState extends State<ButterFlyGlassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Glasses' ),
        backgroundColor: Color(0xFF183765),

      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
        ),
        itemCount: 6, // Number of items
        itemBuilder: (BuildContext context, int index) {
          // You can customize each container with different glasses and buttons here
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,// Shadow color
                  blurRadius: 5, // Spread radius
                  offset: Offset(0, 3), // Offset in x and y
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Placeholder for the glass image
                Image.asset(
                  'assets/BG$index.PNG',
                  width: 100,
                  height: 100,
                ),


                // Button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GlassDetailsPage(glassImage:  'assets/BG$index.PNG'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF183765),
                        minimumSize: Size(30, 40), // Adjust width and height as needed
                      ),
                      child: Text('SEE DETAILS'),
                    ),

                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
