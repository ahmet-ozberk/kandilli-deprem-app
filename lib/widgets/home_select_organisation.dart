import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/utils/enums.dart';

class HomeSelectOrganisation extends ConsumerWidget {
  const HomeSelectOrganisation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(homeController);
    final watch = ref.watch(homeController);
    return GestureDetector(
      onTap: () => Grock.closeGrockOverlay(),
      child: SizedBox.expand(
        child: ColoredBox(
          color: Colors.black26,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: SafeArea(
              child: Container(
                padding: 16.padding,
                child: GrockScaleAnimation(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastLinearToSlowEaseIn,
                  alignment: Alignment.bottomRight,
                  begin: 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GrockFadeAnimation(
                        duration: 1000.milliseconds,
                        child: GrockContainer(
                          onTap: () => read.setDepremType(DepremType.kandilli),
                          padding: [16, 8].horizontalAndVerticalP,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: 16.borderRadius,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Kandilli Rasathanesi",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (watch.depremType == DepremType.kandilli)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.blueAccent,
                                ).paddingOnlyLeft(8),
                            ],
                          ),
                        ),
                      ),
                      12.height,
                      GrockFadeAnimation(
                        duration: 800.milliseconds,
                        child: GrockContainer(
                          onTap: () => read.setDepremType(DepremType.afad),
                          padding: [16, 8].horizontalAndVerticalP,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: 16.borderRadius,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "AFAD",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (watch.depremType == DepremType.afad)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.blueAccent,
                                ).paddingOnlyLeft(8),
                            ],
                          ),
                        ),
                      ),
                      12.height,
                      GrockFadeAnimation(
                        duration: 600.milliseconds,
                        child: GrockContainer(
                          onTap: () => Grock.closeGrockOverlay(),
                          padding: [16, 8].horizontalAndVerticalP,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: 16.borderRadius,
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text(
                              "İptal",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
