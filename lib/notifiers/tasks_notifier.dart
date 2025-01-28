import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/helper/api_client.dart';
import 'package:robinhood_test/helper/tasks_helper.dart';
import '../models/task.dart';

class TasksNotifier extends StateNotifier<Map<String, List<Task>>> {
  final ApiClient apiClient;
  final String tab;
  int _pageNumber = 0; // Start with page 0

  TasksNotifier(this.apiClient, this.tab) : super({}) {
    fetchTasks();
  }

  // Load tasks from API and group by date
  Future<void> fetchTasks() async {
    try {
      final tasks = await apiClient.fetchTasks(tab, _pageNumber);

      if (_pageNumber == 0) {
        // First load: replace state
        state = groupTasksByDate(tasks);
      } else {
        // Subsequent loads: merge with existing state
        final newGroupedTasks = groupTasksByDate(tasks);
        state = {...state, ...newGroupedTasks};
      }

      _pageNumber++; // Increment for next fetch
    } catch (error) {
      debugPrint("Error loading tasks: $error");
    }
  }

  // Delete a task and update the state
  Future<void> deleteTask(String id) async {
    final updatedState = <String, List<Task>>{};

    // Iterate through each group and filter out the task with the matching ID
    state.forEach((key, tasks) {
      final updatedTasks = tasks.where((task) => task.id != id).toList();

      // Only add groups that have remaining tasks
      if (updatedTasks.isNotEmpty) {
        updatedState[key] = updatedTasks;
      }
    });

    // Update the state with the new map
    state = updatedState;
  }
}
