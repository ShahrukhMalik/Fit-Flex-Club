import 'dart:typed_data';
import 'package:fit_flex_club/src/core/common/widgets/zoom_image_widget.dart';
import 'package:flutter/material.dart';

class FitFlexViewImagePage extends StatelessWidget {
  static const route = 'view_image';
  final Uint8List? mediaBytes;
  final String? mediaUrl;

  const FitFlexViewImagePage({
    super.key,
    this.mediaBytes,
    this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Image")),
      body: Center(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (mediaBytes != null) {
      return ZoomImage(
        image: Image.memory(
          mediaBytes!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 80);
          },
        ),
      );
    } else if (mediaUrl != null && mediaUrl!.isNotEmpty) {
      return ZoomImage(
        image: Image.network(
          mediaUrl!,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 80);
          },
        ),
      );
    } else {
      return const Icon(Icons.image_not_supported, size: 80);
    }
  }
}
