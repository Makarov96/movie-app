import 'package:flutter/material.dart';

typedef KueskieBuilder<T> = Widget? Function(BuildContext, int, T);

class KueskieSliverGridToList<T> extends StatefulWidget {
  const KueskieSliverGridToList({
    super.key,
    this.gridToggle,
    required this.trigger,
    required this.contorller,
    required this.toggle,
    required this.data,
    required this.itemBuilder,
  });
  final ScrollController contorller;
  final VoidCallback? gridToggle;
  final bool toggle;
  final List<T> data;
  final VoidCallback trigger;
  final KueskieBuilder<T> itemBuilder;

  @override
  State<KueskieSliverGridToList<T>> createState() =>
      _KueskieSliverGridToListState<T>();
}

class _KueskieSliverGridToListState<T> extends State<KueskieSliverGridToList<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.contorller.addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (widget.contorller.position.pixels ==
        widget.contorller.position.maxScrollExtent) {
      widget.trigger();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      controller: widget.contorller,
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: widget.gridToggle,
                icon: Icon(
                  widget.toggle ? Icons.filter_none : Icons.grid_on,
                ),
              )
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.toggle ? 2 : 1,
              mainAxisSpacing: 20,
              mainAxisExtent: widget.toggle ? 300 : 400,
              crossAxisSpacing: widget.toggle ? 20 : 0,
            ),
            itemCount: widget.data.length,
            itemBuilder: (context, index) =>
                widget.itemBuilder(context, index, widget.data[index]),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    widget.contorller.removeListener(_listener);
  }

  @override
  bool get wantKeepAlive => true;
}
