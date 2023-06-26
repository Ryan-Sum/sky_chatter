// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/services/models/post_model.dart';

class PostUI extends StatefulWidget {
  final String author;
  final String caption;
  final List<dynamic> likes;
  final String link;
  final String id;

  const PostUI({
    Key? key,
    required this.author,
    required this.caption,
    required this.likes,
    required this.link,
    required this.id,
  }) : super(key: key);

  @override
  State<PostUI> createState() => _PostUIState();
}

class _PostUIState extends State<PostUI> {
  @override
  Widget build(BuildContext context) {
    Icon icon = (widget.likes.contains(FirebaseAuth.instance.currentUser!.uid))
        ? const Icon(
            Icons.favorite_rounded,
            color: Colors.red,
          )
        : const Icon(Icons.favorite_border_rounded);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.secondary,
          child: Image.network(widget.link),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    if (widget.likes
                        .contains(FirebaseAuth.instance.currentUser!.uid)) {
                      setState(() {
                        widget.likes
                            .remove(FirebaseAuth.instance.currentUser!.uid);
                      });

                      await FirebaseFirestore.instance
                          .collection('Posts')
                          .get()
                          .then(
                        (value) {
                          for (var element in value.docs) {
                            Post post = Post.fromJson(element.data());
                            if (post.id == widget.id) {
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(element.id)
                                  .update({'likes': widget.likes});
                            }
                          }
                        },
                      );
                    } else {
                      setState(() {
                        widget.likes
                            .add(FirebaseAuth.instance.currentUser!.uid);
                      });
                      await FirebaseFirestore.instance
                          .collection('Posts')
                          .get()
                          .then(
                        (value) {
                          for (var element in value.docs) {
                            Post post = Post.fromJson(element.data());
                            if (post.id == widget.id) {
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(element.id)
                                  .update({'likes': widget.likes});
                            }
                          }
                        },
                      );
                    }
                  },
                  icon: icon),
              Text(
                  "•   ${widget.likes.length} ${widget.likes.length == 1 ? 'Like' : 'Likes'}"),
              const SizedBox(
                width: 16,
              ),
              Text('Posted By: ${widget.author}')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(widget.caption),
        ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
