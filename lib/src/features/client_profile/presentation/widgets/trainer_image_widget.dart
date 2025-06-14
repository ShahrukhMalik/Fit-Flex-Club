import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainerImageWidget extends StatelessWidget {
  final Uint8List? mediaBytes;
  final String? mediaUrl;
  final BoxFit fit; // <-- new param for flexibility

  const TrainerImageWidget({
    super.key,
    this.mediaBytes,
    this.mediaUrl,
    this.fit = BoxFit.cover, // default
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Glass Background (fallback image)
          Image.asset(
            'assets/images/fit_flex_logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Frosted Glass Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.centerLeft,
              child: _buildImage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final imageWidget = mediaBytes != null
        ? Image.memory(
            mediaBytes!,
            fit: fit,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 48),
          )
        : (mediaUrl != null
            ? Image.network(
                mediaUrl!,
                fit: fit,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CupertinoActivityIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 48),
              )
            : const Icon(Icons.image_not_supported, size: 48,));

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white, // Fully visible on left
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.3),
            Colors.transparent, // Fully transparent on right
          ],
          stops: [0.0, 0.8, 0.90, 1.0], // You can tweak these for smoother fade
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn, // This applies transparency
      child: imageWidget,
    );
  }

  // Widget _buildImage() {
  //   if (mediaBytes != null) {
  //     return Image.memory(
  //       mediaBytes!,
  //       fit: fit,
  //       errorBuilder: (context, error, stackTrace) => const Icon(
  //         Icons.broken_image,
  //         size: 48,
  //       ),
  //     );
  //   } else if (mediaUrl != null) {
  //     return Image.network(
  //       mediaUrl!,
  //       fit: fit,
  //       loadingBuilder: (context, child, loadingProgress) {
  //         if (loadingProgress == null) return child;
  //         return const Center(child: CupertinoActivityIndicator());
  //       },
  //       errorBuilder: (context, error, stackTrace) => const Icon(
  //         Icons.broken_image,
  //         size: 48,
  //       ),
  //     );
  //   } else {
  //     return const Icon(
  //       Icons.image_not_supported,
  //       size: 48,
  //     );
  //   }
  // }
}
