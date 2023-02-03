import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({
    super.key,
    required this.productId,
    this.isInWishlist = false,
  });
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist ?? false ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishlist ?? false ? Colors.red : color,
      ),
    );
  }
}
