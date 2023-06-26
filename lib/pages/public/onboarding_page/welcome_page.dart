// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';

import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/page_back_button.dart';
import '../../../global_widgets/page_counter.dart';
import '../../../global_widgets/page_forward_button.dart';
import 'onboarding_pages/onboarding_page_1.dart';
import 'onboarding_pages/onboarding_page_2.dart';
import 'onboarding_pages/onboarding_page_3.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: controller,
              children: const [
                OnboardingPage1(),
                OnboardingPage2(),
                OnboardingPage3()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      PageCounter(
                        controller: controller,
                        count: 3,
                      ),
                      const Spacer(),
                      PageBackButton(controller: controller),
                      const SizedBox(
                        width: 16,
                      ),
                      PageForwardButton(controller: controller)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
