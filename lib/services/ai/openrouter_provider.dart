import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../models/ai_model.dart';
import '../../models/message.dart';
import 'ai_provider.dart';

class OpenRouterProvider implements AIProvider {
  final Dio _dio = DioClient.instance;

  @override
  Future<List<AIModel>> fetchModels({
    required String apiKey,
  }) async {
    final response = await _dio.get(
      ApiConstants.modelsEndpoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    final List<dynamic> data = response.data['data'];

    return data
        .map((model) => AIModel.fromJson(model))
        .toList();
  }

  Future<ChatMessage> sendMessage({
  required String apiKey,
  required String model,
  required List<ChatMessage> messages,
}) async {
  final response = await _dio.post(
    ApiConstants.chatEndpoint,
    options: Options(
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    ),
    data: {
      'model': model,
      'messages': messages.map((message) {
        return {
          'role': message.role.name,
          'content': message.content,
        };
      }).toList(),
    },
  );

  final assistant =
      response.data['choices'][0]['message'];

  return ChatMessage(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    role: MessageRole.assistant,
    content: assistant['content'],
    createdAt: DateTime.now(),
  );
}
}