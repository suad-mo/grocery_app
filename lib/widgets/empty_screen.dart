import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  final String imagePath, title, subtitle, buttonText;
  const EmptyScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final themeState = Utils(context).getTheme;
    final Color color = Utils(context).color;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Whoops!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: title,
                color: Colors.cyan,
                textSize: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: subtitle,
                color: Colors.cyan,
                textSize: 20,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: color, // Colors.white,
                        //Theme.of(context).colorScheme.secondary, // color,
                      ),
                    ),
                    // onPrimary: color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () {
                    GlobalMethod.navigateTo(
                        ctx: context, routeName: FeedsScreen.routeName);
                  },
                  child: TextWidget(
                    text: buttonText,
                    color: themeState
                        ? Colors.grey.shade300
                        : Colors.grey.shade600,
                    textSize: 20,
                    isTitle: true,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
