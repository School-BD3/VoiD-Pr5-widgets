import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';

void main() {
  Widget createTestWidget({
    String text = 'Натисни мене',
    VoidCallback? onPressed,
    CustomButtonStyle style = CustomButtonStyle.primary,
    IconData? icon,
    bool isLoading = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomButton(
            text: text,
            onPressed: onPressed,
            style: style,
            icon: icon,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }

  testWidgets('відображає текст кнопки', (tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('Натисни мене'), findsOneWidget);
  });

  testWidgets('викликає onPressed після натискання', (tester) async {
    var wasPressed = false;

    await tester.pumpWidget(
      createTestWidget(onPressed: () => wasPressed = true),
    );

    await tester.tap(find.byType(FilledButton));
    expect(wasPressed, isTrue);
  });

  testWidgets('підтримує стиль outline', (tester) async {
    await tester.pumpWidget(
      createTestWidget(style: CustomButtonStyle.outline),
    );

    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('показує індикатор завантаження', (tester) async {
    await tester.pumpWidget(createTestWidget(isLoading: true));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
  });

  testWidgets('відображає іконку', (tester) async {
    await tester.pumpWidget(
      createTestWidget(icon: Icons.shopping_cart),
    );

    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });
}