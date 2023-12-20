import 'package:clothcrafted/screens/donationformscreen.dart';
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
      home: ProfileForUser(),
    );
  }
}

class ProfileForUser extends StatefulWidget {
  const ProfileForUser({Key? key}) : super(key: key);

  @override
  _ProfileForUser createState() => _ProfileForUser();
}

class _ProfileForUser extends State<ProfileForUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('donations');

  late TextEditingController _gatherController;
  late TextEditingController _cleanController;
  late TextEditingController _packController;
  late TextEditingController _centerController;
  late TextEditingController _guidelinesController;
  late TextEditingController _dropOffController;

  @override
  void initState() {
    super.initState();
    _gatherController = TextEditingController();
    _cleanController = TextEditingController();
    _packController = TextEditingController();
    _centerController = TextEditingController();
    _guidelinesController = TextEditingController();
    _dropOffController = TextEditingController();
  }

  @override
  void dispose() {
    _gatherController.dispose();
    _cleanController.dispose();
    _packController.dispose();
    _centerController.dispose();
    _guidelinesController.dispose();
    _dropOffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Clothes Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStepTextFormField(
                controller: _gatherController,
                label: '1. Gather gently used clothes',
                hint: 'Sort out clothes that are in good condition and can be reused by others.',
              ),
              buildStepTextFormField(
                controller: _cleanController,
                label: '2. Clean the clothes',
                hint: 'Wash and clean the clothes before donating to ensure they are in good hygiene.',
              ),
              buildStepTextFormField(
                controller: _packController,
                label: '3. Pack the clothes',
                hint: 'Fold and pack the clothes neatly in a box or bag.',
              ),
              buildStepTextFormField(
                controller: _centerController,
                label: '4. Find a donation center',
                hint: 'Locate a local charity, thrift store, or donation center that accepts clothing donations.',
              ),
              buildStepTextFormField(
                controller: _guidelinesController,
                label: '5. Check donation guidelines',
                hint: 'Some organizations may have specific guidelines, so it\'s good to check before donating.',
              ),
              buildStepTextFormField(
                controller: _dropOffController,
                label: '6. Drop off the donation',
                hint: 'Visit the chosen donation center and drop off your clothes during their operating hours.',
              ),
              SizedBox(height: 20),
              Text(
                'Thank you for making a difference!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submitToFirebase();
              print('Form submitted');
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationFormScreen()),
            );
          },
          child: Text('Submit'),
        ),
      ),
    );
  }

  Widget buildStepTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  void _submitToFirebase() {
    _databaseReference.push().set({
      'gather': _gatherController.text,
      'clean': _cleanController.text,
      'pack': _packController.text,
      'center': _centerController.text,
      'guidelines': _guidelinesController.text,
      'dropOff': _dropOffController.text,
    });
  }
}
