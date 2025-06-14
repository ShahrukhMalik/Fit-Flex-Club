import 'package:flutter/material.dart';

class ZoomImage extends StatefulWidget {
  final Image image;

  const ZoomImage({super.key, required this.image});

  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  final TransformationController _transformationController =
      TransformationController();
  TapDownDetails? _doubleTapDetails;
  Offset? _startFocalPoint;
  double _startScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => _doubleTapDetails = details,
      onDoubleTap: _handleDoubleTap,
      onScaleStart: (details) {
        if (details.pointerCount == 2) {
          _startFocalPoint = details.focalPoint;
          _startScale = _transformationController.value.getMaxScaleOnAxis();
        }
      },
      onScaleUpdate: (details) {
        if (details.pointerCount == 2 && _startFocalPoint != null) {
          double scaleChange = details.scale;
          double newScale = (_startScale * scaleChange).clamp(1.0, 4.0);
          _transformationController.value = Matrix4.identity()..scale(newScale);
        }
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: true,
        scaleEnabled: true,
        minScale: 1.0,
        maxScale: 4.0,
        child: widget.image,
      ),
    );
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(2.0);
    }
  }
}
