import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;

  final Set<String> _favoriteIds = <String>{};
  final List<Product> _cart = <Product>[];

  User? get currentUser => _currentUser;

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  List<Product> get cart => List.unmodifiable(_cart);

  int get cartCount => _cart.length;

  bool isFavorite(String productId) {
    if (productId.trim().isEmpty) return false;

    return _favoriteIds.contains(productId);
  }

  void setCurrentUser(User user) {
    if (user.name.trim().isEmpty || user.email.trim().isEmpty) {
      throw ArgumentError('Ім’я та email користувача не можуть бути порожніми.');
    }

    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (productId.trim().isEmpty) {
      throw ArgumentError.value(
        productId,
        'productId',
        'ID товару не може бути порожнім.',
      );
    }

    if (!_favoriteIds.add(productId)) {
      _favoriteIds.remove(productId);
    }

    notifyListeners();
  }

  void addToCart(Product product) {
    _validateProduct(product);

    _cart.add(product);
    notifyListeners();
  }

  bool removeFromCart(String productId) {
    if (productId.trim().isEmpty) return false;

    final index = _cart.indexWhere(
      (product) => product.id == productId,
    );

    if (index == -1) return false;

    _cart.removeAt(index);
    notifyListeners();
    return true;
  }

  void clearCart() {
    if (_cart.isEmpty) return;

    _cart.clear();
    notifyListeners();
  }

  void _validateProduct(Product product) {
    if (product.id.trim().isEmpty) {
      throw ArgumentError('ID товару не може бути порожнім.');
    }

    if (product.name.trim().isEmpty) {
      throw ArgumentError('Назва товару не може бути порожньою.');
    }

    if (!product.price.isFinite || product.price < 0) {
      throw ArgumentError('Ціна товару має бути невід’ємним числом.');
    }
  }
}
