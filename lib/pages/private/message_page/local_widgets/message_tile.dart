// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_chatter/pages/private/message_page/messaging_screen.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.imageLink,
    required this.name,
    required this.id,
  }) : super(key: key);

  final String? imageLink;
  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: (imageLink != null)
                ? Image.network(imageLink!)
                : const Icon(Icons.person_rounded),
          ),
          title: Text(
            name,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessagingScreen(
                          id: id,
                          name: name,
                        )));
          },
        ),
        Divider(
          color: Theme.of(context).colorScheme.surface,
        )
      ],
    );
  }
}
