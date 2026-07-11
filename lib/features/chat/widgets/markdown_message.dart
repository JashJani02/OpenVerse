import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../models/message.dart';
import 'code_block.dart';
import 'markdown_parser.dart';

class MarkdownMessage extends StatelessWidget {
  final ChatMessage message;

  const MarkdownMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final parts = MarkdownParser.parse(message.content);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts.map((part) {
        if (part.isCode) {
          return CodeBlock(
            code: part.content,
            language: part.language,
          );
        }

        return MarkdownBody(
          selectable: true,
          data: part.content,
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.75,
            ),
            h1: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            h2: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            h3: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            strong: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            em: const TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            listBullet: const TextStyle(
              color: Colors.white,
            ),
            blockSpacing: 16,
          ),
        );
      }).toList(),
    );
  }
}