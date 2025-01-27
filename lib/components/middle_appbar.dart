import 'package:flutter/material.dart';

class MiddleAppBar extends StatelessWidget {
  const MiddleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      title: Container(),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      expandedHeight: 75,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Hi! User",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    "This is just a sample UI.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    "Open to create your style :D",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
