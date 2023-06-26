// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String author;
  final String caption;
  final List<dynamic> likes;
  String link;
  final DateTime date;

  Post({
    required this.id,
    required this.author,
    required this.caption,
    required this.likes,
    required this.link,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'caption': caption,
        'likes': likes,
        'link': link,
        'date': date,
      };

  static Post fromJson(Map<String, dynamic> json) {
    Post post = Post(
      id: json['id'],
      author: json['author'],
      caption: json['caption'],
      likes: json['likes'],
      link: json['link'],
      date: (json['date'] as Timestamp).toDate(),
    );
    return post;
  }
}
