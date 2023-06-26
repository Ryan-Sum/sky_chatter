// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthChangeNotifier extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Logs user out globally
  void logout() {
    auth.signOut();
  }

  // Logs user in globally given email and password
  Future<String> login(
      String email, String password, BuildContext context) async {
    String value = 'An error occurred.';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      value = '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        value = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        value = 'Wrong password provided for that user.';
      }
    }
    if (context.mounted) Navigator.pop(context);

    return value;
  }

  // Validates users email given an email
  String? validateEmail(String? email) {
    if (email == null ||
        email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
      return 'Please enter your valid email';
    } else {
      return null;
    }
  }

  // Validates that the user has entered a password given a password
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    } else {
      return null;
    }
  }
}
