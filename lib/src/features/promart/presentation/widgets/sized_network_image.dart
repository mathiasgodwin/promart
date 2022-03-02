import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SizedNetworkImage extends StatelessWidget {
  const SizedNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    this.cacheManager,
  }) : super(key: key);

  final BaseCacheManager? cacheManager;
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageWidth,
      height: imageHeight,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Center(
          child: CachedNetworkImage(
            cacheManager: cacheManager,
            imageUrl: imageUrl,
            placeholder: (_, __) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
