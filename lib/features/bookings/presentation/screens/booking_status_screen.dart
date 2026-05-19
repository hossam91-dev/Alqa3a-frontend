import 'package:flutter/material.dart';

class BookingStatusScreen extends StatelessWidget {
  final String bookingId;

  const BookingStatusScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Status')),
      body: Center(
        child: Text('Status for Booking ID: $bookingId'),
      ),
    );
  }
}