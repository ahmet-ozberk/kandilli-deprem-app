import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';

class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  final HomeController controller;
  @override
  final Size preferredSize;

  HomeAppBar({Key? key, required this.controller})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(homeController);
    final watch = ref.watch(homeController);
    return AppBar(
      title: Hero(
        tag: 'appBarTitle',
        transitionOnUserGestures: true,
        child: Text(
          'Kandilli Deprem',
          style: GoogleFonts.adventPro(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          maxLines: 1,
        ).material(),
      ),
      actions: [
        IconButton(onPressed: ()=>read.toggleSearch(), icon: const Icon(CupertinoIcons.search)),
        GrockMenu(
          items: List.generate(
            10,
            (index) => GrockMenuItem(
              body: Text(
                'Son ${(index + 1) * 50} Deprem',
                style: GoogleFonts.albertSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () => read.setLimit((index + 1) * 50),
              trailing: Icon(
                CupertinoIcons.checkmark_seal,
                color: watch.limit == (index + 1) * 50 ? Colors.green : Colors.transparent,
              ),
            ),
          ),
          child: Tooltip(message: "Sıralama (Son ${watch.limit} Deprem)",decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: 12.borderRadiusOnlyBottomLeftRight,
          ),child: const Icon(Icons.filter_alt_outlined).paddingAll(16)),
        ),
      ],
      centerTitle: false,
    );
  }
}
