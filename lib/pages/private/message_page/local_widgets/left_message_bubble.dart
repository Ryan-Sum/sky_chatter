import 'package:flutter/material.dart';

class LeftMessageBubble extends StatelessWidget {
  const LeftMessageBubble({
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
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
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
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
