// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/functions/user_detail/user_detail_taker.dart';
import 'package:travelapp/screens/sccreen_bottombar.dart';
import 'package:travelapp/screens/screen_login.dart';

class LogAuth {
  String errorMsg = '';

  static checkSignIn({
    required GlobalKey<FormState> formlog,
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (formlog.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
        bool admin =
            // password == '0987654321' && email == 'dibindasky2000@gmail.com'
            currentUserDetail()!.uid=='l9uIf5w0cwb5ebkhF6CsbzvLjQF3'
                ? true
                : false;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenBottomBar(
                    admin: admin,
                  )),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        String errorMsg;

        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMsg = 'Email or password not found';
        } else {
          errorMsg = 'An error occurred, please try again later';
        }

        showDialog(
          context: context,
          barrierDismissible: true, // Allow dismissing the dialog
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorMsg),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    }
  }

  static addUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      var user=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore firebase = FirebaseFirestore.instance;
      CollectionReference userCollection =firebase.collection('users');
      DocumentReference userdoc = userCollection.doc(user.user!.uid);
      Map<String, dynamic> userDetail={
        'name':name,
        'email':email,
        'password':password,
        'profileimg':'',
      };
      await userdoc.set(userDetail);

    } on FirebaseAuthException catch (e) {
      String errorMsg = e.code;

      showDialog(
        context: context,
        barrierDismissible: true, // Allow dismissing the dialog
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(errorMsg),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  static void loginOrHome(BuildContext context, bool logOrNot) async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    logOrNot
        ? Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenBottomBar(
                admin: false,
              ),
            ),
            (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenLogin(),
            ),
            (route) => false);
  }

  static void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenLogin(),
        ),
        (route) => false);
  }
}
