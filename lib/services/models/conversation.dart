// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

class Conversation {
  final List users;
  final String id;

  Conversation({
    required this.users,
    required this.id,
  });

  static Conversation fromJson(Map<String, dynamic> jsonData) => Conversation(
        users: jsonData['users'],
        id: jsonData['id'],
      );
}
