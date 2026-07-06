import '../../models/ai_model.dart';

abstract class AIProvider {
  Future<List<AIModel>> fetchModels({
    required String apiKey,
  });
}