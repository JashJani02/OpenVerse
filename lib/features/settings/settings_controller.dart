import 'package:flutter/material.dart';

import 'package:openverse_v0/core/storage/secure_storage.dart';
import 'package:openverse_v0/models/ai_model.dart';
import 'package:openverse_v0/services/ai/openrouter_provider.dart';

class SettingsController extends ChangeNotifier {
  final TextEditingController apiKeyController = TextEditingController();

  final OpenRouterProvider _provider = OpenRouterProvider();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AIModel> _models = [];
  List<AIModel> get models => _models;

  bool showFreeOnly = true;

  AIModel? selectedModel;

  List<AIModel> get visibleModels {
    if (!showFreeOnly) {
      return _models;
    }

    return _models.where((model) => model.isFree).toList();
  }

  Future<void> loadApiKey() async {
    final key = await SecureStorageService.getApiKey();

    apiKeyController.text = key ?? '';

    notifyListeners();
  }

  Future<void> loadModels() async {
    final apiKey = apiKeyController.text.trim();

    if (apiKey.isEmpty) return;

    _models = await _provider.fetchModels(apiKey: apiKey);

    final savedModelId =
    await SecureStorageService.getSelectedModel();

    if (savedModelId != null) {
      for (final model in _models) {
        if (model.id == savedModelId) {
          selectedModel = model;
          break;
        }
      }
    }

    if (_models.isNotEmpty) {
      selectedModel ??=
          visibleModels.isNotEmpty ? visibleModels.first : _models.first;
    }

    notifyListeners();
  }

  Future<void> saveApiKey() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiKey = apiKeyController.text.trim();

      await SecureStorageService.saveApiKey(apiKey);

      await loadModels();
    } catch (e, stackTrace) {
      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFreeModels(bool value) {
    showFreeOnly = value;

    if (selectedModel != null &&
        !visibleModels.any((m) => m.id == selectedModel!.id)) {
      selectedModel =
          visibleModels.isNotEmpty ? visibleModels.first : null;
    }

    notifyListeners();
  }

 Future<void> selectModel(AIModel? model) async {
  if (model == null) return;

  selectedModel = model;

  await SecureStorageService.saveSelectedModel(model.id);

  notifyListeners();
}

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }
}