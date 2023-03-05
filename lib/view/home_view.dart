import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/widgets/deprem_list_widget.dart';
import 'package:kandilli_deprem/widgets/home_appbar.dart';
import 'package:kandilli_deprem/widgets/home_fab.dart';
import 'package:kandilli_deprem/widgets/loading_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  String search = "";
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeController).isLoading;
    final watch = ref.watch(homeController);
    final read = ref.read(homeController);
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: HomeAppBar(controller: watch),
        floatingActionButton: const HomeFab(),
        body: SafeArea(
          child: isLoading
              ? const LoadingWidget()
              : Stack(
                  children: [
                    RefreshIndicator(
                        onRefresh: () {
                          return read.getData(false);
                        },
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: watch.isSearch ? 44.0 : 0.0),
                          duration: 300.milliseconds,
                          builder: (context, value, child) {
                            return ListView.separated(
                              padding:
                                  EdgeInsets.only(top: 16 + value, bottom: context.bottom + 56, left: 16, right: 16),
                              itemCount: search.isEmpty
                                  ? watch.listItemCount()
                                  : watch.kandilliDepremList
                                      .where((element) =>
                                          element.yer!.toLowerCase().trim().contains(search.toLowerCase().trim()))
                                      .length,
                              controller: read.scrollController,
                              itemBuilder: (context, index) => DepremListItem(
                                jointModel: watch.kandilliDepremList
                                    .where((element) => element.yer!.toLowerCase().trim().contains(
                                          search.toLowerCase().trim(),
                                        ))
                                    .elementAt(index),
                                index: index + 1,
                              ),
                              separatorBuilder: (context, index) => 16.height,
                            );
                          },
                        )),
                    AnimatedSize(
                      duration: 300.milliseconds,
                      child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: watch.isSearch ? 44.0 : 0.0),
                          duration: 300.milliseconds,
                          builder: (context, value, child) {
                            return SizedBox(
                              height: value,
                              child: CupertinoSearchTextField(
                                controller: searchController,
                                placeholder: "Deprem ara",
                                onChanged: (value) {
                                  if (value.length > 2) {
                                    setState(() {
                                      search = value;
                                    });
                                  }
                                },
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: 8.borderRadius,
                                  border: Border.all(color: Colors.grey.shade300),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                onSuffixTap: () {
                                  searchController.clear();
                                  Grock.hideKeyboard();
                                  read.toggleSearch();
                                  setState(() {
                                    search = "";
                                  });
                                },
                                prefixIcon: SizedBox(
                                  height: value,
                                  child: Icon(CupertinoIcons.search, size: watch.isSearch ? 22 : 0),
                                ),
                              ).paddingLTRB(left: 8, right: 8, top: 4),
                            );
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
