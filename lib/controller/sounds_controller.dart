import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kandilli_deprem/assets.dart';

final soundsController = ChangeNotifierProvider((ref) => SoundsController());

class SoundsController extends ChangeNotifier {
  final player = AudioPlayer();
  bool isPlaying = false;

  Future<void> playSound() async {
    if (isPlaying) {
      await player.stop();
      isPlaying = false;
      notifyListeners();
    } else {
      await player.setLoopMode(LoopMode.all);
      await player.setAsset(Assets.sounds.kirmiziIkazMP3);
      isPlaying = true;
      notifyListeners();
      await player.play();
    }
  }
}
