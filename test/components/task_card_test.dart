import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robinhood_test/components/task_card.dart';

void main() {
  group('TaskCard', () {
    testWidgets('renders correctly with TODO status',
        (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskCard(
              tab: 'TODO',
              title: 'Test Task',
              description: 'Test Description',
              id: '1',
              onDismissed: (String id) {
                dismissed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byIcon(Icons.sticky_note_2_rounded), findsOneWidget);

      // Test dismissible functionality
      await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(dismissed, true);
    });

    testWidgets('shows correct icon for different statuses',
        (WidgetTester tester) async {
      // Test DOING status
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskCard(
              tab: 'DOING',
              title: 'Test Task',
              description: 'Test Description',
              id: '1',
              onDismissed: (String id) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.pending_actions_rounded), findsOneWidget);

      // Test DONE status
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskCard(
              tab: 'DONE',
              title: 'Test Task',
              description: 'Test Description',
              id: '1',
              onDismissed: (String id) {},
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byIcon(Icons.task_alt_rounded), findsOneWidget);
    });
  });
}
