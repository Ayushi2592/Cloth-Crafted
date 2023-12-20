// authentication_screen.dart
import 'package:clothcrafted/screens/registrationpage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'registrationpage.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Login'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
              );
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
