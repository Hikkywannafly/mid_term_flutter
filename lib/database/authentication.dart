import 'package:mid_term/screens/home.dart';
import 'package:mid_term/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidateEmailAndPassword {
  final String emailController;
  final String passwordController;
  final BuildContext context;
  bool? state;
  GlobalKey<FormState> key;
  ValidateEmailAndPassword(
      {required this.emailController,
      required this.passwordController,
      required this.context,
      required this.key,
      this.state});
  String errorMessage = '';

  userSignInAndSighnUp() async {
    if (key.currentState!.validate()) {
      try {
        if (state == true) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController, password: passwordController)
              .then(
            (value) {
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          );
          //validation of signup
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController, password: passwordController)
              .then(
            (value) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                  (Route<dynamic> route) => false);
            },
          );
        }
        errorMessage = '';
      } on FirebaseAuthException catch (e) {
        errorMessage = e.code;
        //An error from the firbase will trigger the snack bar
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

signOutUser(BuildContext ctx) {
  FirebaseAuth.instance.signOut().then(
        // ignore: use_build_context_synchronously
        (value) => Navigator.of(ctx).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false),
      );
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email không được để trống';
  }

  return null;
}

String? validatePassword(String? formpass) {
  if (formpass == null || formpass.isEmpty) {
    return 'Mật khẩu không được để trống';
  }
  return null;
}
