import 'package:dio/dio.dart';

import '../../core/network/dio_client.dart';
import '../../models/ai_model.dart';
import '../../models/message.dart';
import '../../models/provider_config.dart';
import 'ai_provider.dart';

class OllamaProvider implements AIProvider {
  final Dio _dio = DioClient.instance;

  static const defaultBaseUrl =
      'http://localhost:11434';

  @override
  Future<List<AIModel>> fetchModels(
    ProviderConfig config,
  ) async {
    final response = await _dio.get(
      '${config.baseUrl ?? defaultBaseUrl}/api/tags',
    );

    final List<dynamic> data =
        response.data['models'];

    return data.map((model) {
      return AIModel(
        id: model['name'],
        name: model['name'],
        isFree: true,
      );
    }).toList();
  }

  @override
  Future<ChatMessage> sendMessage({
    required ProviderConfig config,
    required String model,
    required List<ChatMessage> messages,
  }) async {
    final response = await _dio.post(
      '${config.baseUrl ?? defaultBaseUrl}/api/chat',
      data: {
        'model': model,
        'stream': false,
        'messages': messages
            .map(
              (message) => {
                'role': message.role.name,
                'content': message.content,
              },
            )
            .toList(),
      },
    );

    final assistant =
        response.data['message'];

    return ChatMessage(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      role: MessageRole.assistant,
      content: assistant['content'],
      createdAt: DateTime.now(),
    );
  }
}