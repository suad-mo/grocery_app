import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/on_sale_widgwt.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/OnSaleScreen';
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productOnSale = productProvider.getOnSaleProducts;
    bool isEmpty = false;
    final Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.getScreenSize;

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: productOnSale.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset('assets/images/box.png'),
                    ),
                    Text(
                      'No products on sale yet, \nStay tuned',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(
                productOnSale.length,
                (index) => ChangeNotifierProvider.value(
                  value: productOnSale[index],
                  child: const OnSaleWidget(),
                ),
              ),
            ),
    );
  }
}
