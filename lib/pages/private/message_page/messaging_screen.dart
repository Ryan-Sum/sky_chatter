// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sky_chatter/pages/private/message_page/local_widgets/left_message_bubble.dart';
import 'package:sky_chatter/pages/private/message_page/local_widgets/right_message_bubble.dart';
import 'package:sky_chatter/services/models/message.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  // Gets list of messages from Firebase
  Stream<List<Message>> getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(id)
        .collection("messages")
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var element in event.docs) {
        messages.add(Message.fromJson(element.data()));
      }
      messages.sort(
        (a, b) {
          return b.time.compareTo(a.time);
        },
      );
      return messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.background,
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: StreamBuilder<List<Message>>(
                        stream: getMessages(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(16),
                              reverse: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.elementAt(index).sender ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  return RightMessageBubble(
                                      message:
                                          snapshot.data!.elementAt(index).text);
                                } else {
                                  return LeftMessageBubble(
                                      message:
                                          snapshot.data!.elementAt(index).text);
                                }
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: null,
                            controller: textEditingController,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              label: const Text('Message'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              // Adds message to firebase
                              FirebaseFirestore.instance
                                  .collection("messages")
                                  .doc(id)
                                  .collection("messages")
                                  .doc()
                                  .set({
                                "sender":
                                    FirebaseAuth.instance.currentUser!.uid,
                                "text": textEditingController.text,
                                "time": DateTime.now()
                              });
                              textEditingController.clear();
                            },
                            icon: const Icon(Icons.send_rounded)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
