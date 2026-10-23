import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/utils/app_state.dart';

void main() {
  late AppState appState;

  const product = Product(
    id: 'product-1',
    name: 'Навушники',
    description: 'Бездротові навушники',
    price: 1500,
    imageUrl: 'https://example.com/headphones.png',
  );

  setUp(() {
    appState = AppState();
  });

  tearDown(() {
    appState.dispose();
  });

  group('AppState — обране', () {
    test('додає товар до обраного', () {
      appState.toggleFavorite(product.id);

      expect(appState.isFavorite(product.id), isTrue);
    });

    test('повторне перемикання видаляє товар з обраного', () {
      appState.toggleFavorite(product.id);
      appState.toggleFavorite(product.id);

      expect(appState.isFavorite(product.id), isFalse);
    });

    test('не дозволяє порожній ID', () {
      expect(() => appState.toggleFavorite(''), throwsArgumentError);
    });
  });

  group('AppState — кошик', () {
    test('додає товар до кошика', () {
      appState.addToCart(product);

      expect(appState.cart, hasLength(1));
      expect(appState.cart.first.id, product.id);
      expect(appState.cartCount, 1);
    });

    test('видаляє товар із кошика', () {
      appState.addToCart(product);

      final removed = appState.removeFromCart(product.id);

      expect(removed, isTrue);
      expect(appState.cart, isEmpty);
    });

    test('відхиляє товар із порожнім ID', () {
      const invalidProduct = Product(
        id: '',
        name: 'Товар',
        description: 'Опис',
        price: 100,
        imageUrl: '',
      );

      expect(
        () => appState.addToCart(invalidProduct),
        throwsArgumentError,
      );
    });
  });

  group('AppState — сповіщення', () {
    test('сповіщає слухачів після додавання товару', () {
      var notifications = 0;
      appState.addListener(() {
        notifications++;
      });

      appState.addToCart(product);

      expect(notifications, 1);
    });
  });

  group('AppState — користувач', () {
    test('зберігає поточного користувача', () {
      const user = User(
        name: 'Олена',
        email: 'olena@example.com',
        avatarUrl: 'https://example.com/avatar.png',
      );

      appState.setCurrentUser(user);

      expect(appState.currentUser, user);
    });

    test('відхиляє користувача без імені', () {
      const user = User(
        name: ' ',
        email: 'olena@example.com',
        avatarUrl: '',
      );

      expect(() => appState.setCurrentUser(user), throwsArgumentError);
    });
  });
}
