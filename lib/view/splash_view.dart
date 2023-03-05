import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/assets.dart';

import 'home_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Grock.checkInternet(
      connectBackgroundColor: Colors.transparent
    );
    Future.delayed(800.milliseconds, () {
      Grock.toRemove(const HomeView(), type: NavType.fade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: GrockScaleAnimation(
                duration: const Duration(milliseconds: 600),
                child: Image.asset(
                  Assets.images.splashJPG,
                  fit: BoxFit.cover,
                  height: context.width,
                  width: context.height,
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: GrockGlassMorphism(
              blur: 30,
              child: GrockScaleAnimation(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Hero(
                        tag: 'appBarTitle',
                        transitionOnUserGestures: true,
                        child: Text(
                          'Kandilli Deprem',
                          style: GoogleFonts.adventPro(
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Son Dakika Depremler'.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ).paddingHorizontal(16).paddingOnlyBottom(context.height * 0.33),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
