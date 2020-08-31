import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;

  CustomCachedImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, image) {
          return FittedBox(
            fit: BoxFit.cover,
            child: Image(image: image),
          );
        },
        progressIndicatorBuilder: (context, url, downloadProgress) => FittedBox(
              fit: BoxFit.contain,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 1,
              ),
            ),
        errorWidget: (context, url, error) => FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.error, color: Colors.red),
            ));
  }
}
