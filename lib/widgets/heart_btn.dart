import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
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
      onTap: () async {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethod.errorDialog(
            subtitle: 'No user found. Please login first.',
            context: context,
          );
          return;
        }
        // print('user id is ${user.uid}');
        //  await wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist ?? false ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishlist ?? false ? Colors.red : color,
      ),
    );
  }
}
