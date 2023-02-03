import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/viewed_prod_provider.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList =
        viewedProdProvider.getViewedProdItems.values.toList().reversed.toList();
    print(viewedProdItemsList.toString());

    return viewedProdItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your history is empty',
            subtitle: 'No products has been viewed yet!',
            buttonText: 'Shop now',
            imagePath: 'assets/images/history.png',
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethod.warningDialog(
                        title: 'Empty your history?',
                        subtitle: 'Are you sure?',
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                )
              ],
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              title: TextWidget(
                text: 'History',
                color: color,
                textSize: 24.0,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.builder(
                itemCount: viewedProdItemsList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: ChangeNotifierProvider.value(
                      value: viewedProdItemsList[index],
                      child: const ViewedRecentlyWidget(),
                    ),
                  );
                }),
          );
  }
}
