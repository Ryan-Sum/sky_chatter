import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/global_widgets/forgot_password.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/custom_button.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/images/open_door.svg'),
                  const Spacer(),
                  Text(
                    "Enter Your Information Below",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Spacer(),
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
                  CustomButton(
                    text: 'Login',
                    color: Theme.of(context).colorScheme.primary,
                    function: () async {
                      String message = '';
                      await ref
                          .read(authProvider)
                          .login(emailController.text, passwordController.text,
                              context)
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
                  ),
                  const Spacer(),
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
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          'https://drive.google.com/file/d/1U_0OX2j0veQuuvZloneOABin5wd5VG9Q/view'));
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
            ),
          ),
        ),
      ),
    );
  }
}
