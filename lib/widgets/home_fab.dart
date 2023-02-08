import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/controller/sounds_controller.dart';

class HomeFab extends ConsumerWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShow = ref.watch(homeController).isShowFab;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isShow)
          FloatingActionButton(
            onPressed: () {
              ref.read(homeController).scrollController.animateTo(
                    0,
                    duration: 250.milliseconds,
                    curve: Curves.easeInOut,
                  );
            },
            child: const Icon(
              Icons.arrow_upward,
              size: 20,
            ),
          ),
        const Spacer(),
        FloatingActionButton.extended(
          onPressed: () {
            ref.read(soundsController).playSound();
          },
          label: const Text(
            "Yardım Zili",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ref.watch(soundsController).isPlaying ? Colors.amber : Colors.red,
          icon: const Icon(Icons.crisis_alert_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
