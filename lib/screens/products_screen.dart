import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

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
        title: const Text('Каталог товарів'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onFavoriteChanged: (favorite) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    favorite
                        ? 'Додано до обраного'
                        : 'Видалено з обраного',
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
