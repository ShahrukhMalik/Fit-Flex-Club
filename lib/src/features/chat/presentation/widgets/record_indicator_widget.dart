import 'dart:async';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter/material.dart';

class RecordingIndicator extends StatefulWidget {
  const RecordingIndicator({super.key});

  @override
  State<RecordingIndicator> createState() => _RecordingIndicatorState();
}

class _RecordingIndicatorState extends State<RecordingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _recordingTime = "0:00";

  

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final elapsed = _stopwatch.elapsed;
      setState(() {
        _recordingTime =
            "${elapsed.inMinutes}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: globalColorScheme.onPrimaryContainer.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.multitrack_audio, color: Colors.white, size: 18),
          ),
        ),
        SizedBox(width: 8),
        Text(
          _recordingTime,
          style: TextStyle(
            color: globalColorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
