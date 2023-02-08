import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateTimeChanged;
  final DateTime? initialDateTime;
  const DatePicker({super.key, required this.onDateTimeChanged, this.initialDateTime});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _dateTime = widget.initialDateTime ?? DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GrockScaleAnimation(
      alignment: Alignment.topCenter,
      begin: 0.4,
      end: 1.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GrockButton(
            borderRadius: 32.borderRadius,
            color: Colors.pinkAccent,
            elevation: 10,
            elevationColor: Colors.white.withOpacity(0.5),
            onTap: () {
              widget.onDateTimeChanged(_dateTime);
              Grock.back();
            },
            child: Text(
              'Tamam',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ).paddingAll(12),
          Container(
            height: context.height * 0.24,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: 16.borderRadius,
            ),
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) => setState(() => _dateTime = value),
              initialDateTime: widget.initialDateTime ?? DateTime.now(),
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              backgroundColor: Colors.transparent,
              use24hFormat: true,
              dateOrder: DatePickerDateOrder.dmy,
            ),
          ),
        ],
      ),
    );
  }
}
