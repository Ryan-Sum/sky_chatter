// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:flutter/material.dart';

class RightMessageBubble extends StatelessWidget {
  const RightMessageBubble({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.longestLine,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
