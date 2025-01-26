import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0.0,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-8),
        child: Container(),
      ),
      expandedHeight: 70,
      collapsedHeight: 60,
      surfaceTintColor: Color.fromARGB(255, 245, 251, 251),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
        )
      ],
    );
  }
}
