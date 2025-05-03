import 'dart:typed_data';
import 'dart:ui';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/announcement_entity.dart';
import 'package:flutter/material.dart';

class AnnouncementImageWidget extends StatelessWidget {
  final Uint8List? mediaBytes;
  final String? mediaUrl;

  const AnnouncementImageWidget({
    super.key,
    this.mediaBytes,
    this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Glass Background (random image)
          Image.asset(
            'assets/images/fit_flex_image.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Frosted Glass Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: _buildImage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (mediaBytes != null) {
      return Image.memory(
        mediaBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        // loadingBuilder: (context, child, loadingProgress) {
        //   if (loadingProgress == null) return child;
        //   return const Center(child: CircularProgressIndicator());
        // },
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 48),
      );
    } else if (mediaUrl != null) {
      return Image.network(
        mediaUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 48),
      );
    } else {
      return const Icon(Icons.image_not_supported, size: 48);
    }
  }
}
