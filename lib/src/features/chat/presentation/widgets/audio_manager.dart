import 'package:just_audio/just_audio.dart';
import 'package:flutter/widgets.dart';

class ManagedAudioPlayer {
  final String id;
  final AudioPlayer player;

  ManagedAudioPlayer({required this.id, required this.player});
}

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;
  AudioPlayerManager._internal();

  ManagedAudioPlayer? _currentPlayer;

  ManagedAudioPlayer createManagedPlayer({
    required void Function() onCompleted,
    required void Function(bool isPlaying) onStateChanged,
    String? widgetKey,
  }) {
    final player = AudioPlayer();
    final id = widgetKey ?? UniqueKey().toString();

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.stop();
        onStateChanged(false);
        onCompleted();
        unregisterPlayer(id);
      } else {
        onStateChanged(state.playing);
      }
    });

    final managed = ManagedAudioPlayer(id: id, player: player);
    return managed;
  }

  void registerPlayer(ManagedAudioPlayer managed) {
    if (_currentPlayer != null && _currentPlayer!.id != managed.id) {
      _currentPlayer!.player.pause();
    }
    _currentPlayer = managed;
  }

  void unregisterPlayer(String playerId) {
    if (_currentPlayer?.id == playerId) {
      _currentPlayer = null;
    }
  }

  bool isCurrentPlayer(String playerId) => _currentPlayer?.id == playerId;
}
