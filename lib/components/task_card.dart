import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.tab,
    required this.title,
    required this.description,
    required this.id, // Add a unique identifier for each task
    required this.onDismissed, // Callback to handle task deletion
  });

  final String tab;
  final String title;
  final String description;
  final String id; // Unique identifier for each task
  final Function(String) onDismissed; // Callback to handle deletion

  Icon getIcon() {
    switch (tab) {
      case 'TODO':
        return Icon(Icons.sticky_note_2_rounded,
            color: Color.fromARGB(255, 148, 164, 251));
      case 'DOING':
        return Icon(Icons.pending_actions_rounded,
            color: Color.fromARGB(255, 148, 164, 251));
      case 'DONE':
        return Icon(Icons.task_alt_rounded,
            color: Color.fromARGB(255, 148, 164, 251));
      default:
        return Icon(Icons.pending, color: Color.fromARGB(255, 148, 164, 251));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        // Call the callback to handle task deletion
        onDismissed(id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: getIcon(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
