import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/widgets/animated_counter.dart';

void main() {
  Widget createTestWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: AnimatedCounter(
          initialValue: 0,
          maxValue: 3,
        ),
      ),
    );
  }

  testWidgets('починає з початкового значення', (tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('0 / 3'), findsOneWidget);
  });

  testWidgets('збільшує значення після натискання', (tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.byTooltip('Збільшити'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
  });

  testWidgets('не перевищує максимальне значення', (tester) async {
    await tester.pumpWidget(createTestWidget());

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.byTooltip('Збільшити'));
      await tester.pump(const Duration(milliseconds: 350));
    }

    expect(find.text('3'), findsOneWidget);
    expect(find.text('3 / 3'), findsOneWidget);
    expect(find.text('Максимум досягнуто!'), findsOneWidget);
  });

  testWidgets('зменшує значення після натискання', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedCounter(
            initialValue: 2,
            maxValue: 3,
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Зменшити'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
  });

  testWidgets('скидає значення до початкового', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedCounter(
            initialValue: 2,
            maxValue: 3,
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Скинути'));
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
    expect(find.text('2 / 3'), findsOneWidget);
  });
}
