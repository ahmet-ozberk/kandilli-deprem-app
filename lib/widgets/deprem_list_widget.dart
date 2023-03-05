import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/model/kandilli_deprem_model.dart';
import 'package:kandilli_deprem/utils/custom_color.dart';
import 'package:kandilli_deprem/utils/get_widget_size.dart';
import 'package:kandilli_deprem/view/map_view.dart';

class DepremListItem extends StatefulWidget {
  final DepremModel jointModel;
  final int index;
  const DepremListItem({super.key, required this.jointModel, this.index = 0});

  @override
  State<DepremListItem> createState() => _DepremListItemState();
}

class _DepremListItemState extends State<DepremListItem> with GrockMixin {
  double height = 0;
  @override
  Widget build(BuildContext context) {
    final item = widget.jointModel;
    return GestureDetector(
      onTap: () => Grock.to(MapView(
        lat: double.parse(item.enlem ?? "0"),
        lon: double.parse(item.boylam ?? "0"),
        name: item.yer!,
      )),
      child: GrockFadeAnimation(
        
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: 8.borderRadius,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Row(
                children: [
                  GetWidgetSize(
                    callback: (size, offset) => setStateIfMounted(() => height = size.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subWidget("Konum", item.yer ?? "?", kWhite),
                        const Divider(
                          height: 4,
                        ),
                        subWidget("Tarih", "${item.tarih ?? "?"} - ${item.saat ?? "?"}", kSeashell),
                        const Divider(
                          height: 4,
                        ),
                        subWidget("Derinlik", "${item.derinlik ?? "?"} KM", kPalePink),
                      ],
                    ),
                  ).expanded(),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: context.width * 0.3,
                      minHeight: height,
                    ),
                    padding: [12, 4].horizontalAndVerticalP,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Colors.deepPurple.shade900.withOpacity(0.8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.jointModel.buyukluk ?? "?",
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "Büyüklük",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kWhite),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final watch = ref.watch(homeController);
                return !watch.isShowFab
                    ? const SizedBox.shrink()
                    : Positioned(
                        right: -10,
                        top: -10,
                        child: GrockBlurEffect(
                          child: Text(
                            widget.index.toString(),
                            style: GoogleFonts.arsenal(
                              fontSize: 20,
                            ),
                          ).paddingAll(8),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget subWidget(String title, String desc, Color color) {
    final titleStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: kTitleSmall);
    final descStyle = Theme.of(context).textTheme.labelLarge!.copyWith(color: kDescriptionLarge, fontSize: 16);
    return Container(
      padding: [12, 4].horizontalAndVerticalP,
      decoration: BoxDecoration(
        borderRadius: 12.borderRadius,
        //color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Text(
            desc,
            style: descStyle,
          ),
        ],
      ),
    );
  }
}
