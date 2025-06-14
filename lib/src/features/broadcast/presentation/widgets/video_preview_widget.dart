// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';

// class VideoPreview extends StatefulWidget {
//   final String? filePath;
//   final String? networkUrl;
//   final String? assetPath;
//   final Uint8List? bytes;

//   const VideoPreview({
//     super.key,
//     this.filePath,
//     this.networkUrl,
//     this.assetPath,
//     this.bytes,
//   });

//   @override
//   State<VideoPreview> createState() => _VideoPreviewState();
// }

// class _VideoPreviewState extends State<VideoPreview> {
//   VideoPlayerController? _controller;
//   bool _isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//   }

//   Future<void> _initializeController() async {
//     if (widget.filePath != null) {
//       _controller = VideoPlayerController.file(
//         File(
//           widget.filePath!,
//         ),
//       );
//     } else if (widget.networkUrl != null) {
//       _controller = VideoPlayerController.networkUrl(
//         Uri.parse(
//           widget.networkUrl!,
//         ),
//       );
//     } else if (widget.assetPath != null) {
//       _controller = VideoPlayerController.asset(
//         widget.assetPath!,
//       );
//     } else if (widget.bytes != null) {
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/temp_video.mp4');
//       await file.writeAsBytes(widget.bytes!, flush: true);
//       _controller = VideoPlayerController.file(file);
//     } else {
//       throw Exception('No valid video source provided');
//     }

//     await _controller?.initialize();
//     _controller?.play();
//     _controller?.addListener(() {
//       if (mounted) setState(() {});
//     });

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   String _formatDuration(Duration position) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(position.inMinutes.remainder(60));
//     final seconds = twoDigits(position.inSeconds.remainder(60));
//     return '${position.inHours > 0 ? '${twoDigits(position.inHours)}:' : ''}$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               VideoPlayer(_controller!),
//               _ControlsOverlay(
//                 controller: _controller!,
//                 isPlaying: _isPlaying,
//                 togglePlayPause: () {
//                   setState(() {
//                     _isPlaying ? _controller?.pause() : _controller?.play();
//                     _isPlaying = !_isPlaying;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Text(_formatDuration(_controller!.value.position)),
//               Expanded(
//                 child: Slider(
//                   value: _controller!.value.position.inMilliseconds.toDouble(),
//                   max: _controller!.value.duration.inMilliseconds.toDouble(),
//                   onChanged: (value) {
//                     _controller!.seekTo(Duration(milliseconds: value.toInt()));
//                   },
//                 ),
//               ),
//               Text(_formatDuration(_controller!.value.duration)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ControlsOverlay extends StatelessWidget {
//   final VideoPlayerController controller;
//   final bool isPlaying;
//   final VoidCallback togglePlayPause;

//   const _ControlsOverlay({
//     required this.controller,
//     required this.isPlaying,
//     required this.togglePlayPause,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: togglePlayPause,
//       child: Center(
//         child: AnimatedOpacity(
//           opacity: controller.value.isPlaying ? 0.0 : 1.0,
//           duration: const Duration(milliseconds: 300),
//           child: Icon(
//             isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//             color: Colors.white.withOpacity(0.8),
//             size: 64,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_announcements_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_view_video_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class VideoPreview extends StatefulWidget {
  final String? filePath;
  final String? networkUrl;
  final String? assetPath;
  final Uint8List? bytes;
  final bool isTrainer;

  const VideoPreview({
    super.key,
    this.filePath,
    this.networkUrl,
    this.assetPath,
    this.bytes,
    this.isTrainer = false,
  });

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
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
      // _controller!.play();
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
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
              color: Colors.black.withOpacity(0.3),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _isError
                      ? const Center(
                          child: Icon(Icons.error_outline,
                              color: Colors.white, size: 64),
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

    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller!),
                _ControlsOverlay(
                  controller: _controller!,
                  isPlaying: _isPlaying,
                  togglePlayPause: () {
                    setState(
                      () {
                        _isPlaying ? _controller?.pause() : _controller?.play();
                        _isPlaying = !_isPlaying;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
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
                      _formatDuration(
                        _controller!.value.duration,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _controller?.pause();
                  if (widget.isTrainer) {
                    context.go(
                      '${FitFlexTrainerHubPage.route}/${FitFlexAnnouncementsPage.route}/${FitFlexViewVideoPage.route}',
                      extra: {
                        'mediaUrl': widget.networkUrl,
                        'mediaBytes': widget.bytes,
                      },
                    );
                  } else {
                    context.go(
                      '${FitFlexAnnouncementsPage.clientRoute}/${FitFlexViewVideoPage.route}',
                      extra: {
                        'mediaUrl': widget.networkUrl,
                        'mediaBytes': widget.bytes,
                      },
                    );
                  }
                },
                icon: Icon(
                  Icons.fullscreen,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isPlaying;
  final VoidCallback togglePlayPause;

  const _ControlsOverlay({
    required this.controller,
    required this.isPlaying,
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
          child: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            color: Colors.white.withOpacity(0.8),
            size: 64,
          ),
        ),
      ),
    );
  }
}
