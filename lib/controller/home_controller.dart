import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:intl/intl.dart';
import 'package:kandilli_deprem/model/afad_deprem_model.dart';
import 'package:kandilli_deprem/model/joint_model.dart';
import 'package:kandilli_deprem/model/kandilli_deprem_model.dart';
import 'package:kandilli_deprem/service/api_service.dart';
import 'package:kandilli_deprem/utils/enums.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());

class HomeController extends ChangeNotifier {
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;
  bool isShowFab = false;
  bool isLoading = false;
  bool isError = false;
  DateTime startDate = DateTime(DateTime.now().year - 1);
  DateTime endDate = DateTime.now();
  int limit = 100;
  DepremType depremType = DepremType.kandilli;
  List<KandilliDepremModelResult?> kandilliDepremList = [];
  List<AfadDepremModel?> afadDepremList = [];

  HomeController() {
    scrollController.addListener(onScroll);
    getData();
  }

  JointModel listItem({required int index}) {
    late final JointModel jointModel;
    if (depremType == DepremType.kandilli) {
      jointModel = JointModel(
        date: kandilliDepremList[index]?.date ?? "?",
        location: kandilliDepremList[index]?.lokasyon ?? '?',
        magnitude: kandilliDepremList[index]?.mag.toString() ?? "?",
        depth: kandilliDepremList[index]?.depth.toString() ?? "?",
      );
    } else {
      jointModel = JointModel(
        date: afadDepremList[index]?.date == null
            ? "?"
            : DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(afadDepremList[index]?.date ?? '')),
        location: afadDepremList[index]?.location ?? '?',
        magnitude: afadDepremList[index]?.magnitude.toString() ?? "?",
        depth: afadDepremList[index]?.depth.toString() ?? "?",
      );
    }
    return jointModel;
  }

  int listItemCount() {
    if (depremType == DepremType.kandilli) {
      return kandilliDepremList.length;
    } else {
      return afadDepremList.length;
    }
  }

  void setDate(DateTime date, WhatTime whatTime) {
    if (whatTime == WhatTime.first) {
      startDate = date;
    } else {
      endDate = date;
    }
    getData();
    notifyListeners();
  }

  void setDepremType(DepremType type) {
    depremType = type;
    notifyListeners();
    getData();
    Grock.closeGrockOverlay();
  }

  Future<void> getData([bool isLoad = true]) async {
    if (isLoad) {
      isLoading = true;
      notifyListeners();
    }
    if (depremType == DepremType.kandilli) {
      await _getKandilliDeprem();
    } else {
      await _getAfadDeprem();
    }
    return Future.value();
  }

  Future<void> _getKandilliDeprem() async {
    await ApiService.getKandilliDeprem(limit).then((value) {
      kandilliDepremList = value?.result ?? [];
      print("Data Geldi");
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  Future<void> _getAfadDeprem() async {
    await ApiService.getAfadDeprem(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate), DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate))
        .then((value) {
      afadDepremList = value.reversed.toList();
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  void onScroll() {
    final currentScroll = scrollController.position.pixels;
    if (currentScroll >= scrollThreshold) {
      isShowFab = true;
      notifyListeners();
    } else {
      isShowFab = false;
      notifyListeners();
    }
  }
}
