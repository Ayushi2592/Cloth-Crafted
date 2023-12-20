import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonationFormScreen(),
    );
  }
}

class DonationFormScreen extends StatefulWidget {
  @override
  _DonationFormScreenState createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('userSubmissions');

  final TextEditingController organizationController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void _submitForm() {
    _databaseReference.push().set({
      'organizationName': organizationController.text,
      'contactPersonName': contactPersonController.text,
      'email': emailController.text,
      'phoneNumber': phoneNumberController.text,
      // Add more fields as needed
    }).then((_) {
      print('Form submitted successfully');
    }).catchError((error) {
      print('Error submitting form: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: organizationController,
              decoration: InputDecoration(labelText: 'Organization Name'),
            ),
            TextFormField(
              controller: contactPersonController,
              decoration: InputDecoration(labelText: 'Contact Person Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
