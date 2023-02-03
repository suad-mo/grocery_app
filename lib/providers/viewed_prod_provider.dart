import 'package:flutter/material.dart';
import 'package:grocery_app/models/viewed_model.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProdItems => _viewedProdItems;

  void addProductToHistory({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
        id: DateTime.now().toString(),
        productId: productId,
      ),
    );

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdItems.clear();
    notifyListeners();
  }
}
