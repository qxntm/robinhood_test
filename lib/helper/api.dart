import 'package:dio/dio.dart';
import 'package:robinhood_test/models/api.dart';
import '../models/task.dart';

class ApiClient {
  final Dio dio;

  ApiClient({Dio? customDio}) : dio = customDio ?? Dio();

  Future<ApiResponse> fetchTasks(
    String tab,
    int pageNumber, {
    int offset = 0,
    int limit = 10,
    String sortBy = 'createdAt',
    bool isAsc = true,
    String status = 'TODO',
  }) async {
    try {
      final response = await dio.get(
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list',
        queryParameters: {
          'offset': pageNumber,
          'limit': limit,
          'sortBy': sortBy,
          'isAsc': isAsc,
          'status': tab,
        },
      );

      List<dynamic> taskList = response.data['tasks'];
      int totalPages = response.data['totalPages'] ?? 1;

      return ApiResponse(
        tasks: taskList.map((data) => Task.fromJson(data)).toList(),
        totalPages: totalPages,
      );
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }
}
