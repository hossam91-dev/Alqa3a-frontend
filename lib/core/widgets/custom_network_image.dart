import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart'; // استيراد البكدج هنا

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final BoxShape shape;
  final Widget? errorWidget;
  final Widget? placeholderWidget;
  
  
  final int? memCacheWidth;
  final int? memCacheHeight;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.shape = BoxShape.rectangle,
    this.errorWidget,
    this.placeholderWidget,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.rectangle 
            ? BorderRadius.circular(borderRadius) 
            : null,
      ),
      clipBehavior: Clip.antiAlias, 
      child: imageUrl.isEmpty
          ? _buildErrorWidget()
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: fit,
              memCacheWidth: memCacheWidth,
              memCacheHeight: memCacheHeight,
              
              placeholder: (context, url) => placeholderWidget ?? _buildShimmerPlaceholder(),
              
              errorWidget: (context, url, error) => errorWidget ?? _buildErrorWidget(),
            ),
    );
  }

  
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,      
      highlightColor: Colors.grey[100]!,  
      period: const Duration(milliseconds: 1500), 
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, 
          shape: shape,
          borderRadius: shape == BoxShape.rectangle 
              ? BorderRadius.circular(borderRadius) 
              : null,
        ),
      ),
    );
  }

  
  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(
        Icons.broken_image_outlined,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}