import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kandilli_deprem/model/kandilli_deprem_model.dart';
import 'package:kandilli_deprem/service/web_scraping_service.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());

class HomeController extends ChangeNotifier {
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;
  bool isShowFab = false;
  bool isLoading = false;
  bool isError = false;
  bool isSearch = false;
  int limit = 50;
  List<DepremModel> kandilliDepremList = [];

  HomeController() {
    scrollController.addListener(onScroll);
    getData();
  }

  DepremModel listItem({required int index}) {
    late final DepremModel jointModel;
    jointModel = kandilliDepremList[index];
    return jointModel;
  }

  int listItemCount() {
    return limit;
  }

  void setLimit(int value) {
    limit = value;
    notifyListeners();
  }

  void toggleSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  Future<void> getData([bool isLoad = true]) async {
    if (isLoad) {
      isLoading = true;
      notifyListeners();
    }
    await _getKandilliDeprem();
  }

  Future<void> _getKandilliDeprem() async {
    await WebScrapingService.htmlParse().then((value) {
      kandilliDepremList = value;
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
