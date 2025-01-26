import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/helper/api_client.dart';
import '../models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  final ApiClient apiClient;
  final String tab;

  TasksNotifier(this.apiClient, this.tab) : super([]) {
    _loadTasks(tab);
  }

  Future<void> _loadTasks(String tab,{
    int offset = 0,
    int limit = 10,
    String sortBy = 'createdAt',
    bool isAsc = true,
  }) async {
    // If the state is already populated, don't call the API again
    if (state.isEmpty) {
      try {
        final tasks = await apiClient.fetchTasks(
          tab,
          offset: offset,
          limit: limit,
          sortBy: sortBy,
          isAsc: isAsc,
          status: tab,
        );
        state = tasks; // Update state only if tasks are successfully fetched
      } catch (e) {
        // Handle errors (optional)
        debugPrint("Error fetching tasks: $e");
      }
    }
  }

  Future<void> deleteTask(String id) async {
    // Filter out the task by ID and update the state
    state = state.where((task) => task.id != id).toList();
  }
}
