import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist some items',
            buttonText: 'Add a wish',
            imagePath: 'assets/images/wishlist.png',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: 'Wishlist (${wishlistItemsList.length})',
                color: color,
                textSize: 22,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethod.warningDialog(
                      title: 'Empty your wishlist?',
                      subtitle: 'Are your sure??',
                      fct: () {
                        wishlistProvider.clearWishlist();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      context: context,
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: wishlistItemsList[index],
                  child: const WishlistWidget(),
                );
              },
            ),
          );
  }
}
