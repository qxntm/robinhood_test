import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/components/task_card.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class Contents extends ConsumerStatefulWidget {
  const Contents({super.key, required this.tab});
  final String tab;

  @override
  ConsumerState<Contents> createState() => _ContentsState();
}

class _ContentsState extends ConsumerState<Contents> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(tasksProvider(widget.tab).notifier).fetchTasks();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksMap = ref.watch(tasksProvider(widget.tab));

    if (tasksMap.isEmpty) {
      return const Center(child: Text("No tasks available"));
    }

    return ListView(
      controller: scrollController,
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
                  ref
                      .read(tasksProvider(widget.tab).notifier)
                      .deleteTask(task.id);
                },
                background: Container(color: Colors.red),
                child: TaskCard(
                  tab: widget.tab,
                  title: task.title,
                  description: task.description,
                  id: task.id,
                  onDismissed: (id) {
                    ref.read(tasksProvider(widget.tab).notifier).deleteTask(id);
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
