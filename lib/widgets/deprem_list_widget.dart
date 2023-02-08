import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/model/joint_model.dart';
import 'package:kandilli_deprem/utils/custom_color.dart';
import 'package:kandilli_deprem/utils/get_widget_size.dart';

class DepremListItem extends StatefulWidget {
  final JointModel jointModel;
  const DepremListItem({super.key, required this.jointModel});

  @override
  State<DepremListItem> createState() => _DepremListItemState();
}

class _DepremListItemState extends State<DepremListItem> with GrockMixin{
  double height = 0;
  @override
  Widget build(BuildContext context) {
    final item = widget.jointModel;
    return Row(
      children: [
        GetWidgetSize(
          callback: (size, offset) => setStateIfMounted(() => height = size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subWidget("Konum", item.location, kWhite),
              4.height,
              subWidget("Tarih", item.date, kSeashell),
              4.height,
              subWidget("Derinlik", "${item.depth} KM", kPalePink),
            ],
          ),
        ).expanded(),
        Container(
          constraints: BoxConstraints(
            minWidth: context.width * 0.3,
            minHeight: height,
          ),
          margin: 4.paddingOnlyLeft,
          padding: [12, 4].horizontalAndVerticalP,
          decoration: BoxDecoration(
            borderRadius: 12.borderRadius,
            color: kSpanishPink,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.jointModel.magnitude,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kDescriptionLarge),
              ),
              Text(
                "Büyüklük",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kTitleSmall),
              ),
            ],
          ),
        ),
      ],
    ).paddingHorizontal(16);
  }

  Widget subWidget(String title, String desc, Color color) {
    final titleStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: kTitleSmall);
    final descStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(color: kDescriptionLarge);
    return Container(
      padding: [12, 4].horizontalAndVerticalP,
      decoration: BoxDecoration(
        borderRadius: 12.borderRadius,
        color: color,
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
