import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/components/task_card.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class Contents extends ConsumerWidget {
  const Contents({super.key, required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(
        tasksProvider(tab)); // Watch the tasks provider for the selected tab

    return tasks.isEmpty
        ? const Center(child: CircularProgressIndicator()) // Loading state
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskCard(
                tab: tab,
                title: task.title,
                description:
                    task.description,
                id: task.id,
                onDismissed: (id) {
                  ref.read(tasksProvider(tab).notifier).deleteTask(id);
                },
              );
            },
          );
  }
}
