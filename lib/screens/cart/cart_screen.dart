import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Cart (2)',
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethod.warningDialog(
                title: 'Empty your cart',
                subtitle: 'Are your sure??',
                fct: () {},
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
      body: Column(
        children: [
          _checkout(ctx: context),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return const CartWidget();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    Size size = Utils(ctx).getScreenSize;
    final Color color = Utils(ctx).color;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      // color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Order now',
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            // const Spacer(),
            FittedBox(
              child: TextWidget(
                text: 'Total: \$0.259',
                color: color,
                textSize: 18,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
