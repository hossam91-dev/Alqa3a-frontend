import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go('/home');
          },
          child: Text('Login Screen'),
        ),
      ),
    );
  }
}