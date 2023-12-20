import 'package:clothcrafted/screens/ngodashboardscreen.dart';
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
      home: ProfileForNGO(),
    );
  }
}

class ProfileForNGO extends StatefulWidget {
  @override
  _ProfileForNGO createState() => _ProfileForNGO();
}

class _ProfileForNGO extends State<ProfileForNGO> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('ngoRegistrations');

  late TextEditingController _orgNameController;
  late TextEditingController _contactPersonNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _missionDescriptionController;

  @override
  void initState() {
    super.initState();
    _orgNameController = TextEditingController();
    _contactPersonNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    _missionDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _orgNameController.dispose();
    _contactPersonNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _missionDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(
                controller: _orgNameController,
                label: 'Organization Name',
                hint: 'Enter the name of your NGO',
              ),
              buildTextFormField(
                controller: _contactPersonNameController,
                label: 'Contact Person\'s Name',
                hint: 'Enter the contact person\'s name',
              ),
              buildTextFormField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter the email address',
              ),
              buildTextFormField(
                controller: _phoneNumberController,
                label: 'Phone Number',
                hint: 'Enter the phone number',
              ),
              buildTextFormField(
                controller: _addressController,
                label: 'Address',
                hint: 'Enter the NGO\'s address',
              ),
              buildTextFormField(
                controller: _missionDescriptionController,
                label: 'Mission Description',
                hint: 'Briefly describe the mission of your NGO',
              ),
              SizedBox(height: 20),
              Text(
                'Thank you for your commitment to positive change!',
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
              print('NGO registration form submitted');
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NGODashboardScreen()),
            );
          },
          child: Text('Submit'),
        ),
      ),
    );
  }

  Widget buildTextFormField({
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
      'organizationName': _orgNameController.text,
      'contactPersonName': _contactPersonNameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneNumberController.text,
      'address': _addressController.text,
      'missionDescription': _missionDescriptionController.text,
    });
  }
}
