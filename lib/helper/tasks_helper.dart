import 'package:intl/intl.dart';
import 'package:robinhood_test/models/task.dart'; // Ensure you import this for DateFormat

// Method to group tasks by date
Map<String, List<Task>> groupTasksByDate(List<Task> tasks) {
  final Map<String, List<Task>> groupedTasks = {};
  final now = DateTime.now();

  for (final task in tasks) {
    final taskDate = DateTime.parse(task.createdAt); // Parse ISO 8601 date
    String label;

    // Compare task date with today and tomorrow
    if (isSameDate(taskDate, now)) {
      label = "Today";
    } else if (isSameDate(taskDate, now.add(Duration(days: 1)))) {
      label = "Tomorrow";
    } else {
      // Format other dates as "20 MAY 2023"
      label = DateFormat("d MMM yyyy").format(taskDate).toUpperCase();
    }

    // Add task to the respective date group
    if (!groupedTasks.containsKey(label)) {
      groupedTasks[label] = [];
    }
    groupedTasks[label]!.add(task);
  }

  // Remove any empty groups
  groupedTasks.removeWhere((key, value) => value.isEmpty);

  return groupedTasks;
}

// Helper function to compare dates ignoring time
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
