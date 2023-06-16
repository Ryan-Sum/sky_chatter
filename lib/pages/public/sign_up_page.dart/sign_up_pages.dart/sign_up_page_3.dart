import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/input_field.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_page.dart';
import 'package:url_launcher/url_launcher.dart';

final loginFormKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class SignUpPage3 extends ConsumerWidget {
  const SignUpPage3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                SvgPicture.asset('assets/images/almost_there.svg'),
                const Spacer(),
                Text(
                  "Almost There",
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
                  text: 'Sign Up',
                  color: Theme.of(context).colorScheme.primary,
                  function: () async {
                    bool message = await ref.read(userProvider).signUp(
                        emailController.text.trim(),
                        passwordController.text.trim());
                    if (message == false) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('An error occured...'),
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
                const SizedBox(
                  height: 8,
                ),
                CustomButton(
                    text: 'Cancel',
                    color: Theme.of(context).colorScheme.tertiary,
                    function: () {
                      ref.read(pageController).previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }),
                const Spacer(),
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
    );
  }
}
