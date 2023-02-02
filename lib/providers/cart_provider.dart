import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems => _cartItems;

  void addProductsToCart({
    required String prodctId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      prodctId,
      () => CartModel(
        id: DateTime.now().toString(),
        productId: prodctId,
        quantity: quantity,
      ),
    );
  }
}
