import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_page.dart';

import '../../../../global_widgets/custom_button.dart';
import '../../login_page/login_page.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80),
      child: Column(
        children: [
          SvgPicture.asset('assets/images/mobile_login.svg'),
          Text(
            "Let's Get You Up And Running",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Spacer(),
          CustomButton(
            text: 'I Already Have An Account',
            color: Theme.of(context).colorScheme.primary,
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomButton(
            text: "I Don't Have an Account Yet",
            color: Theme.of(context).colorScheme.surface,
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()));
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}
