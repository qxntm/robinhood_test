import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/components/final_appbar.dart';
import 'package:robinhood_test/components/middle_appbar.dart';
import 'package:robinhood_test/components/top_appbar.dart';
import 'package:robinhood_test/helper/content.dart';
import 'package:robinhood_test/pages/contents.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            const TopAppBar(),
            const MiddleAppBar(),
            FinalAppBar(
              onTabChanged: (int tab) {
                ref.read(selectedTabProvider.notifier).state = tab;
              },
            ),
          ];
        },
        body: Center(
          child: Contents(tab: getContent(selectedTab)),
        ),
      ),
    );
  }
}
