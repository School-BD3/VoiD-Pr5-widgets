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
    return _favoriteIds.contains(productId);
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    notifyListeners();
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(String productId) {
    final index = _cart.indexWhere(
      (product) => product.id == productId,
    );

    if (index != -1) {
      _cart.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    if (_cart.isEmpty) return;

    _cart.clear();
    notifyListeners();
  }
}
