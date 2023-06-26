// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:sky_chatter/pages/private/attendance_page/attendance_page.dart';
import 'package:sky_chatter/pages/private/calendar_page/calendar_page.dart';
import 'package:sky_chatter/pages/private/message_page/message_page.dart';
import 'package:sky_chatter/pages/private/profile_page/profile_page.dart';
import 'package:sky_chatter/pages/private/social_media_page/social_media_page.dart';

import '../../../global_widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Users current page
  int currentIndex = 0;

  // List of pages in bottom nav bar
  List<Widget> pages = [
    const SocialMediaPage(),
    const CalendarPage(),
    const MessagePage(),
    const AttendancePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.share_rounded), label: 'Social Media'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rounded), label: 'Attendance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
