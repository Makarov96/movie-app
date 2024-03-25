import 'package:flutter/material.dart';

class KueskiDrawer extends StatelessWidget {
  const KueskiDrawer({
    super.key,
    required this.title,
    required this.listTiles,
  });

  final String title;

  final List<ListTile> listTiles;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Column(
            children: listTiles,
          ),
        ],
      ),
    );
  }
}
