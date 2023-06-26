// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    // Sends verification email
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    super.initState();
    // Reloads page every 3 seconds to check if email is verified
    Timer.periodic(const Duration(seconds: 3), (_) async {
      FirebaseAuth.instance.currentUser?.reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  "Check Your Inbox",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'A verification email has been sent to your inbox. Make sure you check the spam folder!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                const CircularProgressIndicator(),
                const Spacer(),
                CustomButton(
                    text: 'Resend',
                    color: Theme.of(context).colorScheme.primary,
                    function: () {}),
                const SizedBox(
                  height: 8,
                ),
                CustomButton(
                    text: 'Back',
                    color: Theme.of(context).colorScheme.secondary,
                    function: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
