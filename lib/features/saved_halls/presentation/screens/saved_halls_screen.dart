import 'package:flutter/material.dart';

class SavedHallsScreen extends StatelessWidget {
  const SavedHallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Halls'),
      ),
      body: const Center(
        child: Text('Your saved halls will appear here.'),
      ),
    );
  }
}