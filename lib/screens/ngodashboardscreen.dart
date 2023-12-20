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
      home: NGODashboardScreen(),
    );
  }
}

class NGODashboardScreen extends StatefulWidget {
  @override
  _NGODashboardScreenState createState() => _NGODashboardScreenState();
}

class _NGODashboardScreenState extends State<NGODashboardScreen> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('userSubmissions');

  List<Map<String, dynamic>> _userSubmissions = [];

  @override
  void initState() {
    super.initState();
    _getUserSubmissions();
  }

  void _getUserSubmissions() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>? ?? {};

        List<Map<String, dynamic>> submissions = [];

        values.entries.forEach((entry) {
          submissions.add(Map<String, dynamic>.from(entry.value));
        });

        setState(() {
          _userSubmissions = submissions;
        });

        print('Data received: $_userSubmissions');
      }
    }, onError: (Object error) {
      print('Error getting submissions: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Submissions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _userSubmissions.isEmpty
            ? Center(
          child: Text('No submissions available.'),
        )
            : ListView.builder(
          itemCount: _userSubmissions.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> submission = _userSubmissions[index];
            return ListTile(
              title: Text('Organization Name: ${submission['organizationName']}'),
              subtitle: Text('Contact Person: ${submission['contactPersonName']}'),
              // Add more fields as needed
            );
          },
        ),
      ),
    );
  }
}
