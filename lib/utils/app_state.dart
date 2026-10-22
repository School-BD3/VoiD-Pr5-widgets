import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;

  final Set<String> _favoriteIds = {};
  final List<Product> _cart = [];

  User? get currentUser => _currentUser;

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  List<Product> get cart => List.unmodifiable(_cart);

  int get cartCount => _cart.length;

  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (!_favoriteIds.add(productId)) {
      _favoriteIds.remove(productId);
    }

    notifyListeners();
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.remove(productWhere(productId));
    notifyListeners();
  }

  Product? productWhere(String productId) {
    for (final product in _cart) {
      if (product.id == productId) return product;
    }
    return null;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
