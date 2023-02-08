import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GrockRotateAnimation(
        begin: 0.2,
        end: -0.2,
        addListener: (controller) {
          if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          } else if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
        child: GrockScaleAnimation(
          begin: 0.8,
          child: SvgPicture.asset(Assets.images.turkeyFlagSVG, width: context.width * 0.5, height: context.width * 0.5),
          addListener: (controller) {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else if (controller.status == AnimationStatus.dismissed) {
              controller.forward();
            }
          },
        ),
      ),
    );
  }
}
