import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/on_sale_widgwt.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.33,
            child: Center(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: _offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  ),
                ),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextButton(
            onPressed: () {},
            child: const TextWidget(
              text: 'View All',
              color: Colors.blue,
              textSize: 20,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: size.height * 0.24,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const OnSaleWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
