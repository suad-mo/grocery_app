import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/fetch_screen.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import '../screens/btm_bar.dart';
import '../services/global_methods.dart';
import 'text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const FetchScreen(),
          ));
        } on FirebaseAuthException catch (error) {
          GlobalMethod.errorDialog(
              subtitle: '${error.message}', context: context);
        } catch (error) {
          GlobalMethod.errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const TextWidget(
              text: 'Sign in with google',
              color: Colors.white,
              textSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
