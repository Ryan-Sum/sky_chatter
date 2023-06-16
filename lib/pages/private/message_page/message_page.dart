import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/pages/private/message_page/add_conversation_screen.dart';
import 'package:sky_chatter/pages/private/message_page/local_widgets/conversations.dart';

class MessagePage extends ConsumerWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ConversationScreen(
        getConversations: ref.read(messageProvider).getConversations,
        getUsername: ref.read(messageProvider).getUsername,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddConversationScreen()));
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
