import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController();

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Hi, ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'MyName',
                          style: TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (() {
                              //print('My name is pressed');
                            })),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: 'Email@email.com',
                  color: color,
                  textSize: 18,
                  // isTitle: true,
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(height: 20),
                _listTiles(
                  title: 'Addres 2',
                  subtitle: 'My subtitle',
                  icon: IconlyBold.user2,
                  onPressed: () async {
                    await _showAddressDialog();
                  },
                  color: color,
                ),
                _listTiles(
                  title: 'Orders',
                  icon: IconlyBold.bag,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Wishlist',
                  icon: IconlyBold.heart,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Viewed',
                  icon: IconlyBold.show,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Forget password',
                  icon: IconlyBold.unlock,
                  onPressed: () {},
                  color: color,
                ),
                SwitchListTile(
                  title: TextWidget(
                    text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                    color: color,
                    textSize: 18,
                    // isTitle: true,
                  ),
                  secondary: Icon(
                    themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                  onChanged: (value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme,
                ),
                _listTiles(
                  title: 'Logout',
                  icon: IconlyBold.logout,
                  onPressed: () async {
                    await _showLogoutDialog(color: color);
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              onChanged: ((value) {
                // _addressTextController.text;
                // print(_addressTextController.text);
              }),
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Your address',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (() {
                    //print(_addressTextController.text);
                  }),
                  child: const Text('Update'))
            ],
          );
        });
  }

  Future<void> _showLogoutDialog({required Color color}) async {
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
                width: 10,
              ),
              TextWidget(
                text: 'Sign out',
                color: color,
                textSize: 18,
                isTitle: true,
              )
            ]),
            content: const Text('Do you wonna sign out'),
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
                onPressed: (() {
                  //print('OK');
                }),
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

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle ?? '',
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
