import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/input_field.dart';

TextEditingController emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Please enter your email below. If that email is associated with a registered account, a password reset email will be sent.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                InputField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    isObscured: false,
                    label: 'Email',
                    validator: (email) {
                      if (email == null ||
                          email.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                        return 'Please enter your valid email';
                      } else {
                        return null;
                      }
                    }),
                const Spacer(),
                CustomButton(
                    text: "Send",
                    color: Theme.of(context).colorScheme.primary,
                    function: () async {
                      // ignore: unnecessary_null_comparison
                      if (emailController.text != null ||
                          emailController.text.isNotEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text)) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text)
                              .then((value) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'An email has been sent to: ${emailController.text}'),
                            ));
                            emailController.clear();
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code.toString() == 'invalid-email') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Error: Invalid email'),
                            ));
                          }

                          if (e.code.toString() == 'missing-email') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Error: No email provided'),
                            ));
                          }

                          if (e.code.toString() == 'user-not-found') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Error: User not found'),
                            ));
                          }
                        }
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
