import 'package:ant_manager/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed.
    // Note: AppBar title might not be found if it's not in the tree yet,
    // but in MyApp -> HomeScreen -> Scaffold -> AppBar, it should be.
    // However, pumpWidget might need pumpAndSettle if there are animations or async loading.

    // We are using Providers which load data async.
    // But initial state is empty list.

    // Check for title 'Ant Manager'
    expect(find.text('Ant Manager'), findsOneWidget);

    // Check for bottom navigation labels
    expect(find.text('Colonies'), findsOneWidget);
    expect(find.text('Breeding Sheets'), findsOneWidget);
    expect(find.text('Stock'), findsOneWidget);
  });
}
