import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/components/task_card.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class Contents extends ConsumerWidget {
  const Contents({super.key, required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksMap = ref.watch(tasksProvider(tab));

    if (tasksMap.isEmpty) {
      return const Center(child: Text("No tasks available"));
    }

    return ListView(
      children: tasksMap.entries.map((entry) {
        final label = entry.key;
        final taskList = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ...taskList.map((task) {
              return Dismissible(
                key: ValueKey(task.id),
                onDismissed: (_) {
                  ref.read(tasksProvider(tab).notifier).deleteTask(task.id);
                },
                background: Container(color: Colors.red),
                child: TaskCard(
                  tab: tab,
                  title: task.title,
                  description: task.description,
                  id: task.id,
                  onDismissed: (id) {
                    ref.read(tasksProvider(tab).notifier).deleteTask(id);
                  },
                ),
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }
}
