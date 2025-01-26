import 'package:dio/dio.dart';
import '../models/task.dart';

class ApiClient {
  final Dio dio;

  ApiClient({Dio? customDio}) : dio = customDio ?? Dio();

  Future<List<Task>> fetchTasks(String tab, {
    int offset = 0,
    int limit = 20,
    String sortBy = 'createdAt',
    bool isAsc = true,
    String status = 'TODO',
  }) async {
    try {
      final response = await dio.get(
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list',
        queryParameters: {
          'offset': offset,
          'limit': limit,
          'sortBy': sortBy,
          'isAsc': isAsc,
          'status': tab,
        },
      );

      // Make sure to extract the tasks from the response
      List<dynamic> taskList = response.data['tasks'];  // Access the 'tasks' field
      return taskList.map((data) {
        return Task(
          id: data['id'],
          title: data['title'],
          description: data['description'],  // Ensure you add the description if it exists
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }
}
