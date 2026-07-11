class MarkdownPart {
  final bool isCode;
  final String language;
  final String content;

  const MarkdownPart({
    required this.isCode,
    required this.language,
    required this.content,
  });
}

class MarkdownParser {
  static List<MarkdownPart> parse(String markdown) {
    final regex = RegExp(
      r'```(\w+)?\n([\s\S]*?)```',
      multiLine: true,
    );

    final parts = <MarkdownPart>[];

    int lastIndex = 0;

    for (final match in regex.allMatches(markdown)) {
      if (match.start > lastIndex) {
        parts.add(
          MarkdownPart(
            isCode: false,
            language: '',
            content: markdown.substring(lastIndex, match.start),
          ),
        );
      }

      parts.add(
        MarkdownPart(
          isCode: true,
          language: match.group(1) ?? 'text',
          content: match.group(2)?.trimRight() ?? '',
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < markdown.length) {
      parts.add(
        MarkdownPart(
          isCode: false,
          language: '',
          content: markdown.substring(lastIndex),
        ),
      );
    }

    return parts;
  }
}