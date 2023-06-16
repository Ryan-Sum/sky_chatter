// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sky_chatter/pages/private/message_page/local_widgets/message_tile.dart';
import 'package:sky_chatter/services/models/conversation.dart';

class ConversationScreen extends StatefulWidget {
  final Future<List<Conversation>> Function() getConversations;
  final Future<String> Function(String otherUserId) getUsername;

  const ConversationScreen({
    Key? key,
    required this.getConversations,
    required this.getUsername,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<Conversation> conversations = [];

  void setConversations() async {
    await widget.getConversations().then((value) {
      setState(() {
        conversations = value;
      });
    });
  }

  @override
  void initState() {
    setConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        conversations = await widget.getConversations();
        setState(() {
          conversations;
        });
      },
      child: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          List userIDs = conversations.elementAt(index).users;
          userIDs.remove(FirebaseAuth.instance.currentUser!.uid);

          String otherUserID = userIDs.first;
          return FutureBuilder(
            future: widget.getUsername(otherUserID),
            builder: (context, snapshot2) {
              if (snapshot2.hasData) {
                return MessageTile(
                  id: conversations.elementAt(index).id,
                  imageLink: null,
                  name: snapshot2.data!,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
