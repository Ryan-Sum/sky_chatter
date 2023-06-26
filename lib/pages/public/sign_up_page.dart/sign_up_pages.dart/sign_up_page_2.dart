// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/pages/public/sign_up_page.dart/sign_up_page.dart';
import 'package:sky_chatter/services/models/user_model.dart';

class SignUpPage2 extends ConsumerWidget {
  const SignUpPage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DistrictUser user = ref.read(userProvider).districtUser;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset('assets/images/is_this_you.svg'),
          const Spacer(),
          Text(
            "Is This You?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Spacer(),
          Text(
            'Please verify that all of the information below is correct.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(children: [
                  Text('Name: ${user.firstName} ${user.lastName}',
                      style: Theme.of(context).textTheme.labelLarge!),
                  Text('ID Number: ${user.idNumber}',
                      style: Theme.of(context).textTheme.labelLarge!),
                  Text('School: Steinbrenner H.S.',
                      style: Theme.of(context).textTheme.labelLarge!),
                ]),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 2,
                height: 52,
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
                    'No',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 2,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(pageController).nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
