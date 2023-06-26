// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/services/message_change_notifier.dart';
import 'package:sky_chatter/services/models/user_model.dart';

final messageProvider =
    ChangeNotifierProvider((ref) => MessageChangeNotifier());

class AddConversationScreen extends ConsumerWidget {
  const AddConversationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gets list of recipients
    Future<List<DistrictUser>> future =
        ref.read(userProvider).getUserType().then(
      (value) {
        if (value == UserType.teacher) {
          return ref.read(messageProvider).getOthers();
        } else {
          return ref.read(messageProvider).getTeachers();
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Conversation'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.sort(
              (a, b) {
                return a.firstName
                    .toLowerCase()
                    .compareTo(b.firstName.toLowerCase());
              },
            );
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        ref.read(messageProvider).createConversation(
                            snapshot.data!.elementAt(index).authID);
                      },
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: Text(
                          "${snapshot.data!.elementAt(index).firstName} ${snapshot.data!.elementAt(index).lastName}"),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
