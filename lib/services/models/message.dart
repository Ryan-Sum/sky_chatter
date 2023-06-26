// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sender;
  final String text;
  DateTime time;

  Message({
    required this.sender,
    required this.text,
    required this.time,
  });

  static Message fromJson(Map<String, dynamic> jsonData) => Message(
        sender: jsonData['sender'],
        text: jsonData['text'],
        time: (jsonData['time'] as Timestamp).toDate(),
      );
}
