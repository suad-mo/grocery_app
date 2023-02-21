import 'package:flutter/material.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductSearch = [];
  // @override
  // void initState() {
  //   final productsProvider =
  //       Provider.of<ProductsProvider>(context, listen: false);
  //   productsProvider.fetchProducts();
  //   super.initState();
  // }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productsProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      listProductSearch = productsProvider.serchQuery(value);
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.greenAccent,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.greenAccent,
                        width: 1,
                      ),
                    ),
                    hintText: 'What\'s in your mind ',
                    prefixIcon: const Icon(Icons.search),
                    suffix: IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        _searchTextFocusNode.unfocus();
                      },
                      icon: Icon(
                        Icons.close,
                        color:
                            _searchTextFocusNode.hasFocus ? Colors.red : color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // GridView.count(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   crossAxisCount: 2,
            //   padding: EdgeInsets.zero,
            //   // crossAxisSpacing: 10,
            //   childAspectRatio: size.width / (size.height * 0.59),
            //   children: List.generate(
            //     allProducts.length,
            //     (index) => ChangeNotifierProvider.value(
            //       value: allProducts[index],
            //       child: const FeedsWidget(),
            //     ),
            //   ),
            // )
            _searchTextController.text.isNotEmpty && listProductSearch.isEmpty
                ? const EmptyProductsWidget(
                    text: 'No products found, please tray anoder keyword!')
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.59),
                    children: List.generate(
                      _searchTextController.text.isNotEmpty
                          ? listProductSearch.length
                          : allProducts.length,
                      (index) => ChangeNotifierProvider.value(
                        value: _searchTextController.text.isNotEmpty
                            ? listProductSearch[index]
                            : allProducts[index],
                        child: const FeedsWidget(),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
