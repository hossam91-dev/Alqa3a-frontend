import 'package:alqa3a/core/config/app_configuration.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_theme.dart';
import 'package:flutter/material.dart';


void main() async {
  await AppConfiguration.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
