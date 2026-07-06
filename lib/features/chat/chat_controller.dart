import 'package:flutter/material.dart';

import '../../core/storage/secure_storage.dart';
import '../../models/message.dart';
import '../../services/ai/openrouter_provider.dart';

class ChatController extends ChangeNotifier {
  final OpenRouterProvider _provider = OpenRouterProvider();

  final TextEditingController messageController =
      TextEditingController();

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  bool _isSending = false;

  bool get isSending => _isSending;

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    final apiKey =
        await SecureStorageService.getApiKey();

    final model =
        await SecureStorageService.getSelectedModel();

    if (apiKey == null || model == null) {
      debugPrint("API Key or model missing.");
      return;
    }

    final userMessage = ChatMessage(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      role: MessageRole.user,
      content: text,
      createdAt: DateTime.now(),
    );

    _messages.add(userMessage);

    messageController.clear();

    _isSending = true;
    notifyListeners();

    try {
      final assistant = await _provider.sendMessage(
        apiKey: apiKey,
        model: model,
        messages: _messages,
      );

      _messages.add(assistant);
    } catch (e) {
      debugPrint(e.toString());
    }

    _isSending = false;
    notifyListeners();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}