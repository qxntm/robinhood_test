import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:robinhood_test/helper/api_client.dart';

@GenerateMocks([Dio])
import 'api_client_test.mocks.dart';

void main() {
  group('ApiClient', () {
    late MockDio mockDio;
    late ApiClient apiClient;

    setUp(() {
      mockDio = MockDio();
      apiClient = ApiClient(customDio: mockDio);
    });

    test('fetchTasks returns list of tasks on success', () async {
      final mockResponse = {
        'tasks': [
          {
            'id': '1',
            'title': 'Test Task',
            'description': 'Test Description',
            'createdAt': '2024-03-15T10:00:00Z',
          }
        ]
      };

      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await apiClient.fetchTasks('TODO', 0);

      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].title, 'Test Task');
    });

    test('fetchTasks throws exception on error', () async {
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(Exception('Network error'));

      expect(
        () => apiClient.fetchTasks('TODO', 0),
        throwsException,
      );
    });
  });
}
