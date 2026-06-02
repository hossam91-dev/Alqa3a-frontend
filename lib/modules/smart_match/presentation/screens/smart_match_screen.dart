import 'package:flutter/material.dart';

class SmartMatchScreen extends StatelessWidget {
  const SmartMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Match'),
      ),
      body: const Center(
        child: Text('Smart Match Screen'),
      ),
    );
  }
}