import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cartscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedItems = [];

  // List of image URLs and prices for the GridView
  List<Map<String, dynamic>> gridData = [
    {
      'imageUrl': 'https://www.shutterstock.com/image-vector/stylish-fashion-models-pretty-young-260nw-1012979371.jpg',
      'price': 19.99,
    },
    {
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_SMM4EANx9WTejTfmeQE-69cH7olPRZnwQ07WEOxsHQ&s',
      'price': 29.99,
    },
    {
      'imageUrl': 'https://www.example.com/image3.jpg',
      'price': 24.99,
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: selectedItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black, // Set the background color to black for the content area
        child: Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: [
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkUxfFrCXOOPWxDZO-n0hrKfc6dilB3-JIzIXF4vePwgIqsq4cAlmB6DqVrbnU8Z8nBWY&usqp=CAU',
                'https://img.freepik.com/free-photo/portrait-handsome-confident-model-sexy-stylish-man-fashion-hipster-male-posing-near-wall-studio-isolated_158538-23697.jpg',
                'https://media.istockphoto.com/id/1092747388/photo/stylish-cute-girls-with-skateboard.jpg?s=612x612&w=0&k=20&c=RgQ3ajqDJI1UvnX3_KJIxRcXovDuusjzkkAvK3hGcG0=',
              ].map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItems.add(item);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(''), // You can add any overlay widget if needed
                    ),
                  ),
                );
              }).toList(),
            ),

            // Add some space
            SizedBox(height: 16),

            // Grid View
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,  // Adjust spacing between grid items horizontally
                  mainAxisSpacing: 16.0,   // Adjust spacing between grid items vertically
                ),
                itemCount: gridData.length,
                itemBuilder: (context, index) {
                  String imageUrl = gridData[index]['imageUrl'];
                  double price = gridData[index]['price'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItems.add(imageUrl);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.7),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '\$$price',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
