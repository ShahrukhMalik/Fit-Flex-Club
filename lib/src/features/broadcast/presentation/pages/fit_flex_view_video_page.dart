import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class FitFlexViewVideoPage extends StatefulWidget {
  static const route = 'view_video';
  final String? filePath;
  final String? networkUrl;
  final String? assetPath;
  final Uint8List? bytes;

  const FitFlexViewVideoPage({
    super.key,
    this.filePath,
    this.networkUrl,
    this.assetPath,
    this.bytes,
  });

  @override
  State<FitFlexViewVideoPage> createState() =>
      _FitFlexViewVideoImagePageState();
}

class _FitFlexViewVideoImagePageState extends State<FitFlexViewVideoPage> {
  VideoPlayerController? _controller;
  bool _isPlaying = true; // Default true because we are autoplaying
  bool _isError = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      if (widget.filePath != null) {
        _controller = VideoPlayerController.file(File(widget.filePath!));
      } else if (widget.networkUrl != null) {
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.networkUrl!));
      } else if (widget.assetPath != null) {
        _controller = VideoPlayerController.asset(widget.assetPath!);
      } else if (widget.bytes != null) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_video.mp4');
        await file.writeAsBytes(widget.bytes!, flush: true);
        _controller = VideoPlayerController.file(file);
      } else {
        throw Exception('No valid video source provided');
      }

      await _controller!.initialize();
      await _controller!.play(); // Autoplay here
      _controller!.addListener(() {
        if (mounted) setState(() {});
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return '${position.inHours > 0 ? '${twoDigits(position.inHours)}:' : ''}$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Video"),
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fit_flex_logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _isError
                      ? const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 64,
                          ),
                        )
                      : _buildVideoPlayer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_controller == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller!),
                  _ControlsOverlay(
                    controller: _controller!,
                    togglePlayPause: () {
                      setState(() {
                        if (_controller!.value.isPlaying) {
                          _controller?.pause();
                        } else {
                          _controller?.play();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(_formatDuration(_controller!.value.position),
                          style: const TextStyle(color: Colors.white)),
                      Expanded(
                        child: Slider(
                          value: _controller!.value.position.inMilliseconds
                              .toDouble(),
                          max: _controller!.value.duration.inMilliseconds
                              .toDouble(),
                          onChanged: (value) {
                            _controller!
                                .seekTo(Duration(milliseconds: value.toInt()));
                          },
                        ),
                      ),
                      Text(
                        _formatDuration(_controller!.value.duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback togglePlayPause;

  const _ControlsOverlay({
    required this.controller,
    required this.togglePlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlayPause,
      child: Center(
        child: AnimatedOpacity(
          opacity: controller.value.isPlaying ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
                color: Colors.white.withOpacity(0.8),
                size: 64,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
