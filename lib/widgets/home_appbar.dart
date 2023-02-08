import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/utils/enums.dart';
import 'package:kandilli_deprem/view/filter_view.dart';
import 'package:kandilli_deprem/widgets/home_select_organisation.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final HomeController controller;
  @override
  final Size preferredSize;

  HomeAppBar({Key? key, required this.controller})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Hero(
        tag: 'appBarTitle',
        transitionOnUserGestures: true,
        child: Text(
          '${controller.depremType.name} Deprem',
          style: GoogleFonts.adventPro(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          maxLines: 1,
        ),
      ),
      actions: [
        GrockMenu(
          items: [
            GrockMenuItem(
              text: "Kurum Seç",
              trailing: const Icon(CupertinoIcons.arrowshape_turn_up_right),
              onTap: () {
                Grock.showGrockOverlay(child: const HomeSelectOrganisation());
              },
            ),
            GrockMenuItem(
              text: "Filtrele",
              trailing: const Icon(CupertinoIcons.slider_horizontal_3),
              onTap: () {
                Navigator.push(
                  context,
                  GrockFullScreenModal(
                    slideTransitionType: SlideTransitionType.fromTop,
                    builder: (context, animation, secondaryAnimation) => const FilterView(),
                  ),
                );
              },
            ),
          ],
          backgroundColor: Colors.white,
          pressColor: Colors.grey.shade200,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(CupertinoIcons.settings),
          ),
        ),
      ],
      centerTitle: false,
    );
  }
}
