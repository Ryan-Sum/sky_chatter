import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(pageController).previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool message = await ref
                                  .read(userProvider)
                                  .signUp(emailController.text.trim(),
                                      passwordController.text.trim());
                              if (message == false) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('An error occurred...'),
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
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                      child: TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://ryan-sum.github.io/sky_chatter/#/privacy'));
                        },
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey,
                          ),
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
    });
  }
}
