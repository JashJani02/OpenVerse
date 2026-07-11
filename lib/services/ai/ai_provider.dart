import '../../models/ai_model.dart';
import '../../models/message.dart';
import '../../models/provider_config.dart';

abstract class AIProvider {
  Future<List<AIModel>> fetchModels(
    ProviderConfig config,
  );

  Future<ChatMessage> sendMessage({
    required ProviderConfig config,
    required String model,
    required List<ChatMessage> messages,
  });
}