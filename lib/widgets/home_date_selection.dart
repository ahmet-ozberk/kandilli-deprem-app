import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:intl/intl.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/utils/enums.dart';
import 'package:kandilli_deprem/widgets/date_picker.dart';

class HomeDateSelection extends ConsumerWidget {
  const HomeDateSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(homeController);
    final watch = ref.watch(homeController);
    return Container(
      padding: [16, 4].horizontalAndVerticalP,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          dateWidget(context, read: read, watch: watch).expanded(),
          const SizedBox(width: 16),
          dateWidget(context, text: "Bitiş", read: read, watch: watch, whatTime: WhatTime.seconds).expanded(),
        ],
      ),
    );
  }

  Widget dateWidget(BuildContext context,
      {String text = "Başlangıç",
      WhatTime whatTime = WhatTime.first,
      required HomeController read,
      required HomeController watch}) {
    return GrockContainer(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) => DatePicker(
          onDateTimeChanged: (newDate) => read.setDate(newDate, whatTime),
          initialDateTime: whatTime == WhatTime.first ? watch.startDate : watch.endDate,
        ),
      ),
      padding: 8.padding,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: 16.borderRadius,
      ),
      child: Column(
        children: [
          Text(
            '$text Tarihi',
            style: GoogleFonts.encodeSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            DateFormat('dd MMMM yyyy', 'tr').format(whatTime == WhatTime.first ? watch.startDate : watch.endDate),
            style: GoogleFonts.encodeSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
