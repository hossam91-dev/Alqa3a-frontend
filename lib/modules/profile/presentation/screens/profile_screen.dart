import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomLoading(),
    );
  }
}