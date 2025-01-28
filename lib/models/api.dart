import 'package:robinhood_test/models/task.dart';

class ApiResponse {
  final List<Task> tasks;
  final int totalPages;

  ApiResponse({required this.tasks, required this.totalPages});
}