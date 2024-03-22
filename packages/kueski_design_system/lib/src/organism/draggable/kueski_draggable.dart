import 'package:flutter/material.dart';

class KueskiDraggable extends StatelessWidget {
  const KueskiDraggable({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Container(
                height: sizeOf.height,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: child),
          ),
        );
      },
    );
  }
}
