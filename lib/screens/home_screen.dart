import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../utils/app_state.dart';
import '../widgets/animated_counter.dart';
import '../widgets/custom_button.dart';
import '../widgets/product_card.dart';
import '../widgets/profile_widget.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;

  const HomeScreen({
    super.key,
    required this.appState,
  });

  static const User currentUser = User(
    name: 'Олександр',
    email: 'oleksandr@example.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
  );

  static const Product sampleProduct = Product(
    id: 'headphones',
    name: 'Бездротові навушники',
    description: 'Зручні навушники для музики та навчання.',
    price: 1299,
    imageUrl: 'https://picsum.photos/seed/headphones/600/400',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій застосунок'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  const SizedBox(width: 6),
                  Text('${appState.cartCount}'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Вітаємо у застосунку!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Знайомимося з можливостями Flutter.'),
          const SizedBox(height: 20),

          const ProfileWidget(user: currentUser),
          const SizedBox(height: 16),
          const ProfileWidget(
            user: currentUser,
            isCompact: true,
          ),

          const SizedBox(height: 24),
          const Text(
            'Рекомендований товар',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ProductCard(
            product: sampleProduct,
            initiallyFavorite: appState.isFavorite(sampleProduct.id),
            onFavoriteChanged: (_) {
              appState.toggleFavorite(sampleProduct.id);
            },
            onAddToCart: () {
              appState.addToCart(sampleProduct);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Товар додано до кошика'),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          Text(
            'Обраних товарів: ${appState.favoriteIds.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 24),
          const AnimatedCounter(
            initialValue: 0,
            maxValue: 10,
          ),

          const SizedBox(height: 32),
          Text(
            'Бібліотека компонентів',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Приклади стилів кнопок, які можна використовувати '
            'в різних частинах застосунку.',
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              CustomButton(
                text: 'Primary',
                onPressed: () => _showMessage(context, 'Primary'),
                icon: Icons.check,
              ),
              CustomButton(
                text: 'Secondary',
                style: CustomButtonStyle.secondary,
                onPressed: () => _showMessage(context, 'Secondary'),
              ),
              CustomButton(
                text: 'Danger',
                style: CustomButtonStyle.danger,
                onPressed: () => _showMessage(context, 'Danger'),
                icon: Icons.delete_outline,
              ),
              CustomButton(
                text: 'Outline',
                style: CustomButtonStyle.outline,
                onPressed: () => _showMessage(context, 'Outline'),
                icon: Icons.info_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String styleName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Натиснуто кнопку $styleName')),
    );
  }
}
