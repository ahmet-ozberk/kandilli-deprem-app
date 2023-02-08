import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class FilterView extends ConsumerStatefulWidget {
  const FilterView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterViewState();
}

class _FilterViewState extends ConsumerState<FilterView> {
  @override
  Widget build(BuildContext context) {
    return GrockKeyboardClose(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GrockGlassMorphism(
            borderRadius: 16.borderRadius,
            opacity: 0.6,
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: 16.borderRadius,
                  borderSide: BorderSide.none,
                ),
                hintText: 'Ara...',
                suffixIcon: CupertinoButton(child: const Icon(CupertinoIcons.search), onPressed: () {}),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.height * 0.5),
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                  stops: [0.0, 0.08, 0.92, 1.0], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.separated(
                separatorBuilder: (context, index) => 4.height,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return Card(
                      child:
                          ListTile(title: Text('Item $index'), trailing: Checkbox(value: false, onChanged: (val) {})));
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GrockButton(
                borderRadius: 32.borderRadius,
                color: Colors.redAccent,
                height: 46,
                onTap: () {
                  Grock.back();
                },
                child: Text(
                  'İptal',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
              ).expanded(flex: 12),
              const Spacer(),
              GrockButton(
                borderRadius: 32.borderRadius,
                color: Colors.blueAccent,
                height: 46,
                onTap: () {
                  Grock.back();
                },
                child: Text(
                  'Uygula',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
              ).expanded(flex: 12),
            ],
          ),
        ],
      ),
    ).paddingHorizontal(16).material();
  }
}
