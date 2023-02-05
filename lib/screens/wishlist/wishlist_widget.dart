import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final getCurrProduct =
        productProvider.findProdById(wishlistModel.productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Utils utils = Utils(context);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final Color color = utils.color;
    Size size = utils.getScreenSize;
    // bool? _isInWishlist =
    //     wishlistProvider.getWishlistItems.containsKey(productModel.id);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          // GlobalMethod.navigateTo(
          //     ctx: context, routeName: ProductDetails.routeName);
          Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: getCurrProduct.id,
          );
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: color,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  // width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: getCurrProduct.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Consumer<CartProvider>(builder: (_, myCart, ch) {
                            final isInCart = myCart.getCartItems
                                .containsKey(getCurrProduct.id);
                            return IconButton(
                              onPressed: isInCart
                                  ? null
                                  : () {
                                      myCart.addProductsToCart(
                                        productId: getCurrProduct.id,
                                        quantity: 1,
                                      );
                                    },
                              icon: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                // IconlyLight.bag2,
                                color:
                                    isInCart ? Colors.green : color, // color,
                              ),
                            );
                          }),
                          HeartBTN(
                            productId: getCurrProduct.id,
                            isInWishlist: isInWishlist,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: getCurrProduct.title,
                      color: color,
                      textSize: 20,
                      maxLine: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '\$${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18,
                      maxLine: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
