import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/forgot_password.dart';
import 'package:sky_chatter/main.dart';
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
          Spacer(),
          Text(
            "If you would like to make changes to your accout (including account deletion) please contact your school's office at: \n(813) 792 - 5131",
            textAlign: TextAlign.center,
          ),
          SizedBox(
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
          SizedBox(
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
          Spacer(),
          CustomButton(
              text: 'Logout',
              color: Theme.of(context).colorScheme.primary,
              function: () {
                ref.read(authProvider).logout();
              }),
          SizedBox(
            height: 16,
          ),
        ],
      )),
    );
  }
}
