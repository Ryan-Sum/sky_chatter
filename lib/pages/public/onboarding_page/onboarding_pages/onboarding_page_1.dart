import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80),
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset('assets/images/map.svg'),
          const Spacer(),
          Text(
            "Stay Connected",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'SkyChatter allows everyone around the school, parents, teachers, and students to stay connected and informed.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
