import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robinhood_test/helper/api.dart';
import 'package:robinhood_test/main.dart';
import 'package:robinhood_test/models/api.dart';
import 'package:robinhood_test/providers/state_provider.dart';

class MockApiClient extends ApiClient {
  @override
  Future<ApiResponse> fetchTasks(
    String tab,
    int pageNumber, {
    int offset = 0,
    int limit = 10,
    String sortBy = 'createdAt',
    bool isAsc = true,
    String status = 'TODO',
  }) async {
    return ApiResponse(tasks: [], totalPages: 1);
  }
}

void main() {
  tearDown(() {
    TestWidgetsFlutterBinding.ensureInitialized()
        .window
        .clearPhysicalSizeTestValue();
    TestWidgetsFlutterBinding.ensureInitialized()
        .window
        .clearDevicePixelRatioTestValue();
  });

  testWidgets('App should render without errors', (WidgetTester tester) async {
    // Set a reasonable screen size for testing
    tester.binding.window.physicalSizeTestValue = Size(400, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the API client provider with our mock
          apiClientProvider.overrideWithValue(MockApiClient()),
        ],
        child: MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the app renders without throwing any errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
