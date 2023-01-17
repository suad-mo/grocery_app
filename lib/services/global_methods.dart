import 'package:flutter/material.dart';

class GlobalMethod {
  static navigateTo({
    required BuildContext ctx,
    required String routeName,
  }) {
    Navigator.pushNamed(ctx, routeName);
  }
}
