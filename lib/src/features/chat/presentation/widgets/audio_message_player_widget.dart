import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class AudioMessagePlayerWidget extends StatefulWidget {
  final Uint8List? mediaBytes;
  final String? mediaUrl;

  const AudioMessagePlayerWidget({
    super.key,
    this.mediaBytes,
    this.mediaUrl,
  });

  @override
  State<AudioMessagePlayerWidget> createState() =>
      _AudioMessagePlayerWidgetState();
}

class _AudioMessagePlayerWidgetState extends State<AudioMessagePlayerWidget> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  bool _loadError = false;

  // final _waveformController = PlayerController();

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _initializePlayer();
      },
    );
  }

  Future<File> writeBytesToTempFile(Uint8List bytes, String filename) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');

    return await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> _initializePlayer() async {
    try {
      String? path;

      if (widget.mediaBytes != null) {
        final audioFile = await writeBytesToTempFile(
          widget.mediaBytes!,
          'chat_audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
        );
        path = audioFile.path;
        await _player.setFilePath(path);
      } else if (widget.mediaUrl != null && widget.mediaUrl!.isNotEmpty) {
        path = widget.mediaUrl!;
        await _player.setUrl(path);
      } else {
        setState(() => _loadError = true);
        return;
      }

      // 👇 Connect waveform controller to this audio source
      // _waveformController
      //   // ..playerState = PlayerState.stopped
      //   ..preparePlayer(path: path);

      _duration = _player.duration ?? Duration.zero;

      _player.positionStream.listen((pos) {
        setState(() {
          _position = pos;
        });
      });

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          // Reset player
          _player.seek(Duration.zero);
          _player.stop();
          setState(() {
            _position = Duration.zero;
            _isPlaying = false;
          });
        } else {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });
    } catch (e) {
      print('Error loading audio: $e');
      setState(() => _loadError = true);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    // _waveformController.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    if (_isPlaying) {
      _player.pause();

      // _waveformController.pausePlayer();
    } else {
      _player.play();
      // _waveformController.startPlayer();
    }
    setState(() {});
  }

  String _formatDuration(Duration d) {
    final totalSeconds = d.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_loadError) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: globalColorScheme.onPrimaryContainer.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.grey.shade600),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Audio not available',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: globalColorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Play/pause button
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              size: 32,
              color: globalColorScheme.tertiary,
            ),
            onPressed: _togglePlayback,
          ),
          // const SizedBox(width: 10),

          // Waveform + Slider
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AudioFileWaveforms(
                //   size: const Size(double.infinity, 30),
                //   playerController: _waveformController,
                //   playerWaveStyle: PlayerWaveStyle(
                //     fixedWaveColor: globalColorScheme.onPrimaryContainer,
                //     liveWaveColor: globalColorScheme.tertiary,
                //     showSeekLine: true,
                //   ),
                //   enableSeekGesture: false,
                // ),
                Slider(
                  value: _position.inMilliseconds.toDouble().clamp(
                        0.0,
                        _duration.inMilliseconds.toDouble(),
                      ),
                  min: 0,
                  max: _duration.inMilliseconds.toDouble(),
                  activeColor: globalColorScheme.tertiary,
                  inactiveColor: globalColorScheme.onPrimaryContainer,
                  onChanged: (value) async {
                    await _player.seek(Duration(milliseconds: value.toInt()));
                  },
                ),
              ],
            ),
          ),

          // Remaining time
          Text(
            _formatDuration(_duration - _position),
            style: TextStyle(fontSize: 13, color: Colors.green.shade900),
          ),
        ],
      ),
    );
  }
}

// class AudioMessagePlayerWidget extends StatefulWidget {
//   final String audioUrl;

//   const AudioMessagePlayerWidget({super.key, required this.audioUrl});

//   @override
//   State<AudioMessagePlayerWidget> createState() =>
//       _AudioMessagePlayerWidgetState();
// }

// class _AudioMessagePlayerWidgetState extends State<AudioMessagePlayerWidget> {
//   late AudioPlayer _player;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _player = AudioPlayer();

//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     try {
//       await _player.setUrl(widget.audioUrl);
//       _duration = _player.duration ?? Duration.zero;

//       _player.positionStream.listen((pos) {
//         setState(() {
//           _position = pos;
//         });
//       });

//       _player.playerStateStream.listen((state) {
//         setState(() {
//           _isPlaying = state.playing;
//         });
//       });
//     } catch (e) {
//       print('Error loading audio: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   void _togglePlayback() {
//     _isPlaying ? _player.pause() : _player.play();
//   }

//   String _formatDuration(Duration d) {
//     return d.toString().split('.').first.substring(2);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       margin: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.green.shade100,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Play/pause button
//           IconButton(
//             icon: Icon(
//               _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//               size: 32,
//               color: Colors.green.shade800,
//             ),
//             onPressed: _togglePlayback,
//           ),
//           SizedBox(width: 10),

//           // Waveform + Slider
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AudioFileWaveforms(
//                   size: Size(double.infinity, 30),
//                   playerController: PlayerController(),
//                   playerWaveStyle: const PlayerWaveStyle(
//                     fixedWaveColor: Colors.green,
//                     liveWaveColor: Colors.greenAccent,
//                     showSeekLine: false,
//                   ),
//                   enableSeekGesture: false,
//                 ),
//                 Slider(
//                   value: _position.inMilliseconds
//                       .toDouble()
//                       .clamp(0.0, _duration.inMilliseconds.toDouble()),
//                   min: 0,
//                   max: _duration.inMilliseconds.toDouble(),
//                   activeColor: Colors.green.shade800,
//                   inactiveColor: Colors.green.shade300,
//                   onChanged: (value) async {
//                     await _player.seek(Duration(milliseconds: value.toInt()));
//                   },
//                 ),
//               ],
//             ),
//           ),

//           // Time
//           Text(
//             _formatDuration(_duration - _position),
//             style: TextStyle(fontSize: 13, color: Colors.green.shade900),
//           ),
//         ],
//       ),
//     );
//   }
// }
