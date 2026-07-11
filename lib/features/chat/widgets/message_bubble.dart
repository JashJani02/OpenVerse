import 'package:flutter/material.dart';
//import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../models/message.dart';
import 'markdown_message.dart';
import 'response_actions.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.isUser
        ? _UserMessage(message: message)
        : _AssistantMessage(message: message);
  }
}

class _UserMessage extends StatelessWidget {
  final ChatMessage message;

  const _UserMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 80, right: 12, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message.content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.55,
          ),
        ),
      ),
    );
  }
}

class _AssistantMessage extends StatelessWidget {
  final ChatMessage message;

  const _AssistantMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
  children: [
    const CircleAvatar(
      radius: 15,
      child: Icon(
        Icons.auto_awesome,
        size: 16,
      ),
    ),

    const SizedBox(width: 10),

    const Text(
      "OpenVerse",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.white,
      ),
    ),

    const Spacer(),

    ResponseActions(
      response: message.content,
    ),
  ],
),

            const SizedBox(height: 18),

            MarkdownMessage(
                  message: message,
          ),
          ],
        ),
      ),
    );
  }
}
