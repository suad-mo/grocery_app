import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:uuid/uuid.dart';

import '../widgets/text_widget.dart';

class GlobalMethod {
  static navigateTo({
    required BuildContext ctx,
    required String routeName,
  }) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(title),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: (() {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }),
                child: const TextWidget(
                  text: 'Cancel',
                  color: Colors.cyan,
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const TextWidget(
                  text: 'OK',
                  color: Colors.red,
                  textSize: 18,
                  isTitle: true,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('An Error occurred'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: (() {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }),
                child: const TextWidget(
                  text: 'Ok',
                  color: Colors.cyan,
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final cardId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cardId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      errorDialog(subtitle: e.toString(), context: context);
    }
    // _cartItems.putIfAbsent(
    //   productId,
    //   () => CartModel(
    //     id: DateTime.now().toString(),
    //     productId: productId,
    //     quantity: quantity,
    //   ),
    // );
    // notifyListeners();
  }

  static Future<void> addToWishlist({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      errorDialog(subtitle: e.toString(), context: context);
    }
  }
}
