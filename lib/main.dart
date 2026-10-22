import 'package:flutter/material.dart';

import 'models/user.dart';
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const User currentUser = User(
    name: 'Олександр',
    email: 'oleksandr@example.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій профіль'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Вітаємо у застосунку!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Тут ми знайомимося з віджетами Flutter.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 24),

                const ProfileWidget(
                  user: currentUser,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Компактний профіль',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                const ProfileWidget(
                  user: currentUser,
                  isCompact: true,
                ),

                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Кнопка працює!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Перевірити кнопку'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
