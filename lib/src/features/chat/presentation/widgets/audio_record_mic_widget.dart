import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/chat/presentation/widgets/record_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

// class DragExpandMic extends StatefulWidget {
//   const DragExpandMic({super.key});

//   @override
//   _DragExpandMicState createState() => _DragExpandMicState();
// }

// class _DragExpandMicState extends State<DragExpandMic>
//     with SingleTickerProviderStateMixin {
//   double _scale = 1.0;
//   double _offsetX = 0.0;
//   bool _isPressed = false;

//   final double _maxDrag = -150.0;

//   void _onLongPressStart(_) {
//     setState(() {
//       _scale = 1.5;
//       _isPressed = true;
//     });
//   }

//   void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
//     if (_isPressed) {
//       setState(() {
//         _offsetX = details.offsetFromOrigin.dx.clamp(_maxDrag, 0.0);
//       });
//     }
//   }

//   void _onLongPressEnd(_) {
//     setState(() {
//       _scale = 1.0;
//       _offsetX = 0.0;
//       _isPressed = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPressStart: _onLongPressStart,
//       onLongPressMoveUpdate: _onLongPressMoveUpdate,
//       onLongPressEnd: _onLongPressEnd,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 200),
//         transform: Matrix4.identity()
//           ..translate(_offsetX)
//           ..scale(_scale),
//         alignment: Alignment.topLeft,
//         child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             Icons.mic,
//             size: 30,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DragExpandMic extends StatefulWidget {
//   @override
//   _DragExpandMicState createState() => _DragExpandMicState();
// }

// class _DragExpandMicState extends State<DragExpandMic>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   double _dragOffset = 0.0;
//   final double _maxDrag = -150.0;
//   bool _isPressed = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 200),
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//   }

//   void _onLongPressStart(_) {
//     _controller.forward();
//     setState(() => _isPressed = true);
//   }

//   void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
//     if (_isPressed) {
//       setState(() {
//         _dragOffset = details.offsetFromOrigin.dx.clamp(_maxDrag, 0.0);
//       });
//     }
//   }

//   void _onLongPressEnd(_) {
//     _controller.reverse();
//     setState(() {
//       _dragOffset = 0.0;
//       _isPressed = false;
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPressStart: _onLongPressStart,
//       onLongPressMoveUpdate: _onLongPressMoveUpdate,
//       onLongPressEnd: _onLongPressEnd,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.translate(
//             offset: Offset(_dragOffset, 0),
//             child: Transform.scale(
//               scale: _scaleAnimation.value,
//               alignment: Alignment.bottomRight,
//               child: child,
//             ),
//           );
//         },
//         child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(Icons.mic, size: 30, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

class DragExpandMic extends StatefulWidget {
  final Function(Uint8List audioBytes)? onAudioRecorded;
  const DragExpandMic({super.key, this.onAudioRecorded});

  @override
  _DragExpandMicState createState() => _DragExpandMicState();
}

class _DragExpandMicState extends State<DragExpandMic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _dragOffset = 0.0;
  final double _maxDrag = -150.0;
  bool _isPressed = false;

  final AudioRecorder _record = AudioRecorder();
  String? _recordedFilePath;
  bool _isRecording = false;
  bool _isCancelled = false;

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Platform.isIOS) {
      return "${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
    } else {
      return "${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.mp3";
    }
  }

  Future<void> _startRecording() async {
    final permissionStatus = await Permission.microphone.status;

    if (permissionStatus.isGranted) {
      final path = await _getFilePath();
      await _record.start(RecordConfig(), path: path);
      _recordedFilePath = path;
      setState(() {
        _isRecording = true;
      });
    } else if (permissionStatus.isDenied) {
      final newStatus = await Permission.microphone.request();

      if (newStatus.isGranted) {
        final path = await _getFilePath();
        await _record.start(RecordConfig(), path: path);
        _recordedFilePath = path;
        setState(() {
          _isRecording = true;
        });
      } else if (newStatus.isPermanentlyDenied) {
        if (Platform.isAndroid) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Microphone Permission Needed",
            message:
                "Please enable microphone permission from settings to record audio.",
            confirmText: "Open Settings",
            cancelText: "Cancel",
            onConfirm: openAppSettings,
            onCancel: context.pop,
          );
        } else {
          final path = await _getFilePath();
          await _record.start(RecordConfig(), path: path);
          _recordedFilePath = path;
          setState(() {
            _isRecording = true;
          });
        }
      } else {
        debugPrint("Microphone permission denied.");
        setState(() {
          _isRecording = false;
          _dragOffset = 0.0;
          _isPressed = false;
          _isCancelled = false;
        });
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      if (Platform.isAndroid) {
        PlatformDialog.showAlertDialog(
          context: context,
          title: "Microphone Permission Needed",
          message:
              "Please enable microphone permission from settings to record audio.",
          confirmText: "Open Settings",
          cancelText: "Cancel",
          onConfirm: openAppSettings,
          onCancel: context.pop,
        );
        debugPrint("Microphone permission denied.");
        setState(() {
          _isRecording = false;
          _dragOffset = 0.0;
          _isPressed = false;
          _isCancelled = false;
        });
      } else {
        final path = await _getFilePath();
        await _record.start(RecordConfig(), path: path);
        _recordedFilePath = path;
        setState(() {
          _isRecording = true;
        });
      }
    }
  }

  Future<void> _stopRecording() async {
    await _record.stop();
    setState(() => _isRecording = false);
    _sendAudio(_recordedFilePath);
  }

  Future<void> _cancelRecording() async {
    await _record.cancel();
    _recordedFilePath = null;
    setState(() => _isRecording = false);
  }

  Future<void> _sendAudio(String? path) async {
    if (path != null && File(path).existsSync()) {
      print("Audio sent: $path"); // Replace this with actual upload/send logic
      final bytes = await File(path).readAsBytes();
      widget.onAudioRecorded!(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Audio sent")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Audio not found")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  Future<void> _onLongPressStart(_) async {
    _controller.forward();
    await _startRecording();
    setState(() => _isPressed = true);
  }

  Future<void> _onLongPressMoveUpdate(
      LongPressMoveUpdateDetails details) async {
    if (_isPressed) {
      setState(() {
        _dragOffset = details.offsetFromOrigin.dx.clamp(_maxDrag, 0.0);
      });
      if (_dragOffset == _maxDrag) {
        if (!_isCancelled) {
          await _cancelRecording();
          print("Cancelled Recording");
          setState(() => _isCancelled = true);
        }
      }
    }
  }

  Future<void> _onLongPressEnd(_) async {
    if (!_isCancelled) {
      _controller.reverse();
      await _stopRecording();
      setState(() {
        _dragOffset = 0.0;
        _isPressed = false;
      });
    } else {
      _controller.reverse();
      setState(() {
        _isRecording = false;
        _dragOffset = 0.0;
        _isPressed = false;
        _isCancelled = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _cancelTextOpacity => _isPressed ? 1.0 : 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onLongPressStart: _onLongPressStart,
        onLongPressMoveUpdate: _onLongPressMoveUpdate,
        onLongPressEnd: _onLongPressEnd,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_isPressed) RecordingIndicator(),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Slide to cancel text
                    AnimatedOpacity(
                      opacity: _cancelTextOpacity,
                      duration: Duration(milliseconds: 150),
                      child: Transform.translate(
                        offset: Offset(_dragOffset / 2, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.2)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Slide to cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 50),
                    // Mic button
                    Transform.translate(
                      offset: Offset(_dragOffset, 0),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.bottomRight, // Expands top-left
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _isPressed
                                ? Colors.green
                                : globalColorScheme.onPrimaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
