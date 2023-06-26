// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/global_widgets/forgot_password.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/input_field.dart';
import '../../../main.dart';

final loginFormKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/open_door.svg'),
                      const Spacer(),
                      Text(
                        "Login Below",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        isObscured: false,
                        label: 'Email',
                        validator: (value) =>
                            ref.read(authProvider).validateEmail(value),
                      ),
                      const SizedBox(height: 8),
                      InputField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        isObscured: true,
                        label: 'Password',
                        validator: (value) =>
                            ref.read(authProvider).validatePassword(value),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () async {
                            String message = '';
                            await ref
                                .read(authProvider)
                                .login(emailController.text,
                                    passwordController.text, context)
                                .then((value) => message = value);
                            if (message != '') {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                  ),
                                );
                              }
                            } else {
                              if (context.mounted) Navigator.pop(context);
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'https://ryan-sum.github.io/sky_chatter/#/privacy'));
                            },
                            child: const Text(
                              'Terms of Service',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
