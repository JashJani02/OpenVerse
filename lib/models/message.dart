import 'package:flutter/foundation.dart';

enum MessageRole {
  system,
  user,
  assistant,
}

@immutable
class ChatMessage {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  bool get isUser => role == MessageRole.user;

  bool get isAssistant => role == MessageRole.assistant;

  bool get isSystem => role == MessageRole.system;

  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    String? content,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role.name,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      role: MessageRole.values.firstWhere(
        (e) => e.name == json['role'],
      ),
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}