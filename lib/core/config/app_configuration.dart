import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../di/service_locator.dart';

class AppConfiguration {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeGoogleSignIn();
    await _initializeServiceLocator();
    _configureSystemUI();
  }

  static Future<void> _initializeGoogleSignIn() async {
    await GoogleSignIn.instance.initialize(
      serverClientId: '655362057324-sfd7ltnfm7jais6puq7tl51dguuio3oh.apps.googleusercontent.com'
    );
  }

  static Future<void> _initializeServiceLocator() async {
    await setupServiceLocator();
  }

  static void _configureSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}