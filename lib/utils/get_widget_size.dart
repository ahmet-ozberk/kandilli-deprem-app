// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class GetWidgetSize extends StatefulWidget {
  final Widget child;
  final Function(Size size, Offset offset) callback;
  const GetWidgetSize({Key? key, required this.child, required this.callback}) : super(key: key);

  @override
  _GetWidgetSizeState createState() => _GetWidgetSizeState();
}

class _GetWidgetSizeState extends State<GetWidgetSize> {
  final _key = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
      final size = renderBox?.size;
      final offset = renderBox?.localToGlobal(Offset.zero);
      widget.callback(size ?? Size.zero, offset ?? Offset.zero);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: _key, child: widget.child);
  }
}
