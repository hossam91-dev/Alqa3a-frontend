import 'package:flutter/material.dart';

class HallDetailsScreen extends StatelessWidget {
  final String hallId;

  const HallDetailsScreen({super.key, required this.hallId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hall Details - $hallId')),
      body: Center(child: Text('Details for Hall ID: $hallId')),
    );
  }
}