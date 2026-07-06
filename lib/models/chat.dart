import 'message.dart';

class Chat {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<ChatMessage> messages;

  const Chat({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.messages,
  });

  Chat copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    List<ChatMessage>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'messages': messages
          .map((message) => message.toJson())
          .toList(),
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      messages: (json['messages'] as List)
          .map((e) => ChatMessage.fromJson(e))
          .toList(),
    );
  }
}