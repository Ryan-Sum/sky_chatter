import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/global_widgets/app_bar.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_pages.dart/sign_up_page_1.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_pages.dart/sign_up_page_2.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_pages.dart/sign_up_page_3.dart';

Provider<PageController> pageController = Provider((ref) => PageController());

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: ref.read(pageController),
              children: const [
                SignUpPage1(),
                SignUpPage2(),
                SignUpPage3(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
