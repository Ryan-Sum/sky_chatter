// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';

class Absence {
  final String name;
  final String reason;
  final DateTime date;

  Absence({
    required this.name,
    required this.reason,
    required this.date,
  });

  static Absence fromJson(Map<String, dynamic> jsonData) => Absence(
        name: jsonData['name'],
        reason: jsonData['reason'],
        date: (jsonData['date'] as Timestamp).toDate(),
      );
}
