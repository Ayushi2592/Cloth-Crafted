import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _amountController = TextEditingController();
  bool _isPaymentProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isPaymentProcessing
                  ? null
                  : () {
                _processPayment();
              },
              child: _isPaymentProcessing
                  ? CircularProgressIndicator()
                  : Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    // Placeholder for payment processing logic
    setState(() {
      _isPaymentProcessing = true;
    });

    // Simulating a delay for payment processing
    Future.delayed(Duration(seconds: 2), () {
      // Perform payment processing logic here
      // You can integrate with a payment gateway in a real-world scenario

      setState(() {
        _isPaymentProcessing = false;
        _amountController.clear(); // Clear the amount after payment
      });

      // Show a success dialog or navigate to a success page
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Payment Successful'),
            content: Text('Thank you for your payment!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
