import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final String hallId;

  const BookingScreen({super.key, required this.hallId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Center(
        child: Text('Booking screen for hall ID: $hallId'),
      ),
    );
  }
}