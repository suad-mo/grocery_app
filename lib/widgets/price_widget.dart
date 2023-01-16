import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
      child: Row(
        children: [
          const TextWidget(
            text: '1.59\$',
            color: Colors.green,
            textSize: 22,
          ),
          const SizedBox(width: 5),
          Text(
            '2.59\$',
            style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          )
        ],
      ),
    );
  }
}
