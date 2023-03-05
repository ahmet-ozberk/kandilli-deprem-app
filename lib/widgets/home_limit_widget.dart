import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/controller/home_controller.dart';

class HomeLimitWidget extends ConsumerStatefulWidget {
  const HomeLimitWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeLimitWidgetState();
}

class _HomeLimitWidgetState extends ConsumerState<HomeLimitWidget> {
  @override
  Widget build(BuildContext context) {
    final read = ref.read(homeController);
    final watch = ref.watch(homeController);
    return GrockContainer(
      padding: [16, 12].horizontalAndVerticalP,
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
          Text(
            "Son ${watch.limit} Deprem",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
