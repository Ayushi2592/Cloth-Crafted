import 'package:clothcrafted/screens/profileforngo.dart';
import 'package:clothcrafted/screens/profileforuser.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your logic for the "Set up your profile for Donation" button
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileForUser()),
                );
                print('Set up your profile for Donation button pressed');
              },
              child: Text('Set up your profile for Donation'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the "Set up your profile as NGO" button
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileForNGO()),
                );
                print('Set up your profile as NGO button pressed');
              },
              child: Text('Set up your profile as NGO'),
            ),
          ],
        ),
      ),
    );
  }
}
