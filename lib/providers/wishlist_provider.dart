import 'package:flutter/material.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems => _wishlistItems;

  void addRemoveProductToWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
