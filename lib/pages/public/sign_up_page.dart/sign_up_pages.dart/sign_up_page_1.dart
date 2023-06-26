// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/input_field.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_page.dart';

class SignUpPage1 extends ConsumerWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();

    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/images/fingerprint.svg'),
                  const Spacer(),
                  Text(
                    "Let’s Get Started",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    'Enter your school issued ID number.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: false),
                    isObscured: false,
                    label: 'ID Number',
                    validator: (value) {
                      if (value?.length != 7) {
                        return 'ID Number must be 7 digits long';
                      } else if (int.tryParse(value!.trim()) == null) {
                        return 'ID Number must only contain numbers.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Call (813) 570 - 2074 to request or to report a problem about your ID number.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: 'Submit',
                    color: Theme.of(context).colorScheme.primary,
                    function: () {
                      if (controller.value.text.length == 7 &&
                          int.tryParse(controller.value.text.trim()) != null) {
                        ref
                            .read(userProvider)
                            .getUser(int.parse(controller.text.trim()))
                            .then((value) {
                          if (value == null) {
                            ref.read(pageController).nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(value),
                              ),
                            );
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
