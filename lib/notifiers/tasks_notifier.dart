import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/helper/api.dart';
import 'package:robinhood_test/helper/tasks_helper.dart';
import '../models/task.dart';

class TasksNotifier extends StateNotifier<Map<String, List<Task>>> {
  final ApiClient apiClient;
  final String tab;
  int _pageNumber = 0;
  int _totalPages = 1;
  bool _isLoading = false;
  bool _hasReachedEnd = false;

  bool get isLoading => _isLoading;
  bool get hasReachedEnd => _hasReachedEnd;

  TasksNotifier(this.apiClient, this.tab) : super({}) {
    fetchTasks();
  }

  // Load tasks from API and group by date
  Future<void> fetchTasks() async {
    if (_isLoading || _hasReachedEnd) return;

    try {
      _isLoading = true;
      final response = await apiClient.fetchTasks(tab, _pageNumber);

      _totalPages = response.totalPages;
      final tasks = response.tasks;

      if (_pageNumber == 0) {
        state = groupTasksByDate(tasks);
      } else {
        final newGroupedTasks = groupTasksByDate(tasks);
        state = {...state, ...newGroupedTasks};
      }

      _pageNumber++;
      _hasReachedEnd = _pageNumber >= _totalPages;
    } catch (error) {
      debugPrint("Error loading tasks: $error");
    } finally {
      _isLoading = false;
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
