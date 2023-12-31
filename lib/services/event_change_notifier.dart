// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/services/models/event.dart';

class EventChangeNotifier extends ChangeNotifier {
  // Gets all events from Firebase
  Future<List<Event>> getEvents() async {
    List<Event> events = await FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((value) {
      return value.docs.map((e) => Event.fromJson(e.data())).toList();
    });
    return events;
  }
}
