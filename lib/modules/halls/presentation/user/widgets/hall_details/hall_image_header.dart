import 'package:alqa3a/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class HallImageHeader extends StatelessWidget {
  final String imageUrl;

  const HallImageHeader({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: 250,
    );
  }
}
