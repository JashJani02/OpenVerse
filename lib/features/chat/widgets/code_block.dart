import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
//import 'package:flutter_highlight/themes/github.dart';
//import 'package:flutter_highlight/themes/monokai.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'copy_button.dart';

class CodeBlock extends StatelessWidget {
  final String code;
  final String language;

  const CodeBlock({
    super.key,
    required this.code,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white12),
              ),
            ),
            child: Row(
  children: [
    Text(
      language.isEmpty
          ? "TEXT"
          : language.toUpperCase(),
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),

    const Spacer(),

    CopyButton(
      text: code,
    ),
  ],
),
            ),

          SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  padding: const EdgeInsets.all(16),
  child: HighlightView(
    code,
    language: language,
    theme: {
  ...atomOneDarkTheme,
  'root': const TextStyle(
    color: Colors.white,
    backgroundColor: Colors.transparent,
  ),
},
    padding: EdgeInsets.zero,
    textStyle: const TextStyle(
      fontFamily: 'monospace',
      fontSize: 14,
      height: 1.5,
    ),
  ),
),
        ],
      ),
    );
  }
}