import 'package:flutter_test/flutter_test.dart';
import 'package:robinhood_test/helper/tasks_helper.dart';
import 'package:robinhood_test/models/task.dart';

void main() {
  group('TasksHelper', () {
    test('groupTasksByDate should correctly group tasks', () {
      final now = DateTime.now();
      final tomorrow = now.add(Duration(days: 1));
      final nextWeek = now.add(Duration(days: 7));

      final tasks = [
        Task(
          id: '1',
          title: 'Today Task',
          description: 'Test',
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: '2',
          title: 'Tomorrow Task',
          description: 'Test',
          createdAt: tomorrow.toIso8601String(),
        ),
        Task(
          id: '3',
          title: 'Future Task',
          description: 'Test',
          createdAt: nextWeek.toIso8601String(),
        ),
      ];

      final result = groupTasksByDate(tasks);

      expect(result.containsKey('Today'), true);
      expect(result.containsKey('Tomorrow'), true);
      expect(result['Today']?.length, 1);
      expect(result['Tomorrow']?.length, 1);
    });

    test('isSameDate should correctly compare dates', () {
      final date1 = DateTime(2024, 3, 15, 10, 30);
      final date2 = DateTime(2024, 3, 15, 15, 45);
      final date3 = DateTime(2024, 3, 16, 10, 30);

      expect(isSameDate(date1, date2), true);
      expect(isSameDate(date1, date3), false);
    });
  });
}
