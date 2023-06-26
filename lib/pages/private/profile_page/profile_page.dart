// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/forgot_password.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/services/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        children: [
          const Spacer(),
          FutureBuilder(
            future: ref.read(userProvider).getName(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          FutureBuilder(
            future: ref.read(userProvider).getUserType(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == UserType.parent) {
                  return const Text('Parent');
                } else if (snapshot.data == UserType.teacher) {
                  return const Text('Teacher');
                } else {
                  return const Text('Student');
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const Spacer(),
          const Text(
            "If you would like to make changes to your account (including account deletion) please contact your school's office at: \n(813) 570 - 2074",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
            child: const Text(
              'Forgot Your Password?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              String email = Uri.encodeComponent("sumiantororyan@gmail.com");
              String subject = Uri.encodeComponent("Bug Report");
              String body = Uri.encodeComponent(
                  "Please be descriptive when reporting a bug. Include how the bug occurred, what the bug affected, and screenshots of what happened./n/n Thank you, The SkyChatter Team");
              launchUrl(Uri.parse("mailto:$email?subject=$subject&body=$body"));
            },
            child: const Text(
              'Report A Bug',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          CustomButton(
              text: 'Logout',
              color: Theme.of(context).colorScheme.primary,
              function: () {
                ref.read(authProvider).logout();
              }),
          const SizedBox(
            height: 16,
          ),
        ],
      )),
    );
  }
}
