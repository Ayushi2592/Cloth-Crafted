import 'package:clothcrafted/screens/loginpage.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            'https://e0.pxfuel.com/wallpapers/325/288/desktop-wallpaper-seamless-pattern-of-colorful-clothes-for-stylish-design-for-your-mobile-tablet-explore-clothing-background-clothing-clothing-background-palace-clothing.jpg', // Replace with the path to your background image
            fit: BoxFit.cover,
          ),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text Above Image
                Text(
                  'Cloth Crafted',
                  style: TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16), // Adjust the spacing between the text and image// Adjust the spacing between the image and text b
              ],
            ),
          ),
          // Get Started Button at the Bottom
          SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the home screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Lets Go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

