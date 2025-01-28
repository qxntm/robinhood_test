import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/helper/api_client.dart';
import 'package:robinhood_test/models/task.dart';
import 'package:robinhood_test/notifiers/tasks_notifier.dart';

final selectedTabProvider = StateProvider<int>((ref) => 1);

final apiClientProvider = Provider((ref) => ApiClient());

final tasksProvider = StateNotifierProvider.family<TasksNotifier,
    Map<String, List<Task>>, String>((ref, tab) {
  final apiClient = ref.read(apiClientProvider);
  return TasksNotifier(apiClient, tab);
});
