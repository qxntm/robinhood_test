import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/components/custom_tabbar.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class FinalAppBar extends ConsumerWidget {
  final void Function(int) onTabChanged;

  const FinalAppBar({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return SliverAppBar(
      elevation: 10,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-10),
        child: const Text(''),
      ),
      pinned: true,
      surfaceTintColor: const Color.fromARGB(255, 245, 251, 251),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTabbar(
                  initialValue: selectedTab,
                  children: {
                    1: Text(
                      'To-do',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedTab == 1 ? Colors.white : Colors.grey,
                      ),
                    ),
                    2: Text(
                      'Doing',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedTab == 2 ? Colors.white : Colors.grey,
                      ),
                    ),
                    3: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedTab == 3 ? Colors.white : Colors.grey,
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    // Update Riverpod state
                    ref.read(selectedTabProvider.notifier).state = value;

                    // Notify the parent about the change
                    onTabChanged(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
