import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/assets.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';
import 'package:kandilli_deprem/utils/enums.dart';
import 'package:kandilli_deprem/widgets/deprem_list_widget.dart';
import 'package:kandilli_deprem/widgets/home_appbar.dart';
import 'package:kandilli_deprem/widgets/home_date_selection.dart';
import 'package:kandilli_deprem/widgets/home_fab.dart';
import 'package:kandilli_deprem/widgets/loading_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeController).isLoading;
    final type = ref.watch(homeController).depremType;
    final watch = ref.watch(homeController);
    final read = ref.read(homeController);
    return Scaffold(
      appBar: HomeAppBar(controller: watch),
      floatingActionButton: const HomeFab(),
      body: SafeArea(
        child: isLoading
            ? const LoadingWidget()
            : Column(
                children: [
                  if (type == DepremType.afad) const HomeDateSelection(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return read.getData(false);
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 16, bottom: context.bottom + 56),
                        itemCount: watch.listItemCount(),
                        controller: read.scrollController,
                        itemBuilder: (context, index) => DepremListItem(jointModel: watch.listItem(index: index)),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
