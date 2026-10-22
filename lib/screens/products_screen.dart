import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';
import '../utils/app_state.dart';

class ProductsScreen extends StatelessWidget {
  final AppState appState;

  const ProductsScreen({
    super.key,
    required this.appState,
  });

  static const List<Product> products = [
    Product(
      id: 'headphones',
      name: 'Бездротові навушники',
      description: 'Чудовий звук для музики та навчання.',
      price: 1299,
      imageUrl: 'https://picsum.photos/seed/headphones/600/400',
    ),
    Product(
      id: 'watch',
      name: 'Смартгодинник',
      description: 'Стильний аксесуар на кожен день.',
      price: 1899,
      imageUrl: 'https://picsum.photos/seed/watch/600/400',
    ),
    Product(
      id: 'backpack',
      name: 'Міський рюкзак',
      description: 'Зручний рюкзак для навчання та подорожей.',
      price: 999,
      imageUrl: 'https://picsum.photos/seed/backpack/600/400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Товари · Кошик: ${appState.cartCount}'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            initiallyFavorite: appState.isFavorite(product.id),
            onFavoriteChanged: (_) {
              appState.toggleFavorite(product.id);
            },
            onAddToCart: () {
              appState.addToCart(product);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.name} додано до кошика',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
