import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('застосунок запускається та перемикає вкладки', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);

    var navigationBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );
    expect(navigationBar.selectedIndex, 0);

    await tester.tap(find.textContaining('Товари'));
    await tester.pumpAndSettle();

    navigationBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );
    expect(navigationBar.selectedIndex, 1);

    await tester.tap(find.text('Профіль'));
    await tester.pumpAndSettle();

    navigationBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );
    expect(navigationBar.selectedIndex, 2);

    await tester.tap(find.text('Головна'));
    await tester.pumpAndSettle();

    navigationBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );
    expect(navigationBar.selectedIndex, 0);
  });
}
