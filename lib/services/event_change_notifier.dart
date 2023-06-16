import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/services/models/event.dart';

class EventChangeNotifier extends ChangeNotifier {
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
