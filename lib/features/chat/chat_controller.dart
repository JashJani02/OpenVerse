import 'package:flutter/material.dart';

import '../../core/storage/secure_storage.dart';
import '../../models/message.dart';
import '../../models/provider_config.dart';
import '../../models/provider_type.dart';
import '../../services/ai/provider_factory.dart';

class ChatController extends ChangeNotifier {
  final TextEditingController messageController =
      TextEditingController();

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  bool _isSending = false;

  bool get isSending => _isSending;

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    final providerName =
        await SecureStorageService.getProvider();

    final model =
        await SecureStorageService.getSelectedModel(providerName);

    if (model == null) return;

    final providerType = await SecureStorageService.getProvider();

    final apiKey =
        providerType == ProviderType.openRouter
            ? await SecureStorageService.getApiKey()
            : null;

    final config = ProviderConfig(
      providerType: providerType,
      apiKey: apiKey,
    );

    final provider =
        ProviderFactory.create(config);

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
      final reply =
          await provider.sendMessage(
        config: config,
        model: model,
        messages: _messages,
      );

      _messages.add(reply);
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