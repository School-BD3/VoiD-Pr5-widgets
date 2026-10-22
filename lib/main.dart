import 'package:flutter/material.dart';

import 'models/product.dart';
import 'models/user.dart';
import 'screens/products_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/product_card.dart';
import 'widgets/profile_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const AppNavigation(),
    );
  }
}

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int selectedIndex = 0;

  static const User currentUser = User(
    name: 'Олександр',
    email: 'oleksandr@example.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
  );

  static const Product sampleProduct = Product(
    id: 'product-1',
    name: 'Бездротові навушники',
    description: 'Зручні навушники для музики та навчання.',
    price: 1299,
    imageUrl: 'https://picsum.photos/seed/headphones/600/400',
  );

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHome(),
      const ProductsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Головна',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Товари',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профіль',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій застосунок'),
        centerTitle: true,
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
          ProductCard(product: sampleProduct),
        ],
      ),
    );
  }
}
