import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/widgets/product_card.dart';

void main() {
  const product = Product(
    id: 'test-1',
    name: 'Навушники',
    description: 'Бездротові навушники',
    price: 1500,
    imageUrl: 'https://example.com/headphones.png',
  );

  Widget createTestWidget({
    ValueChanged<bool>? onFavoriteChanged,
    VoidCallback? onAddToCart,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            child: ProductCard(
              product: product,
              onFavoriteChanged: onFavoriteChanged,
              onAddToCart: onAddToCart,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('відображає назву, опис і ціну товару', (tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('Навушники'), findsOneWidget);
    expect(find.text('Бездротові навушники'), findsOneWidget);
    expect(find.textContaining('1500'), findsOneWidget);
  });

  testWidgets('викликає callback після натискання кнопки обраного',
      (tester) async {
    bool? favoriteValue;

    await tester.pumpWidget(
      createTestWidget(
        onFavoriteChanged: (value) {
          favoriteValue = value;
        },
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(favoriteValue, isTrue);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('викликає callback після додавання до кошика',
      (tester) async {
    var wasAdded = false;

    await tester.pumpWidget(
      createTestWidget(
        onAddToCart: () {
          wasAdded = true;
        },
      ),
    );

    await tester.tap(find.byIcon(Icons.add_shopping_cart));
    await tester.pump();

    expect(wasAdded, isTrue);
  });
}