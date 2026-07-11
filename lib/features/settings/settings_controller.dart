import 'package:flutter/material.dart';

import 'package:openverse_v0/core/storage/secure_storage.dart';
import 'package:openverse_v0/models/ai_model.dart';
import '../../models/provider_config.dart';
import '../../models/provider_type.dart';
import '../../services/ai/provider_factory.dart';

class SettingsController extends ChangeNotifier {
  final TextEditingController apiKeyController =
      TextEditingController();

  final TextEditingController ollamaUrlController =
      TextEditingController();

  ProviderType providerType =
      ProviderType.openRouter;

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

    return _models
        .where((m) => m.isFree)
        .toList();
  }

  Future<void> initialize() async {
    providerType =
        await SecureStorageService.getProvider();

    apiKeyController.text =
        await SecureStorageService.getApiKey() ??
            '';

    ollamaUrlController.text =
        await SecureStorageService
                .getOllamaUrl() ??
            'http://localhost:11434';

    await loadModels();
  }

  Future<void> loadModels() async {
    final config = ProviderConfig(
      providerType: providerType,
      apiKey: apiKeyController.text.trim(),
      baseUrl:
          ollamaUrlController.text.trim().isEmpty
              ? null
              : ollamaUrlController.text.trim(),
    );

    final provider =
        ProviderFactory.create(config);

    _models =
        await provider.fetchModels(config);

    final savedModel =
        await SecureStorageService
            .getSelectedModel(providerType);

    if (savedModel != null) {
      for (final model in _models) {
        if (model.id == savedModel) {
          selectedModel = model;
          break;
        }
      }
    }

    if (selectedModel == null &&
        _models.isNotEmpty) {
      selectedModel =
          visibleModels.isNotEmpty
              ? visibleModels.first
              : _models.first;
    }

    notifyListeners();
  }

  Future<void> saveSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      await SecureStorageService.saveProvider(
        providerType,
      );

      if (providerType ==
          ProviderType.openRouter) {
        await SecureStorageService.saveApiKey(
          apiKeyController.text.trim(),
        );
      } else {
        await SecureStorageService
            .saveOllamaUrl(
          ollamaUrlController.text.trim(),
        );
      }

      await loadModels();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setProvider(
    ProviderType type,
  ) async {
    providerType = type;

    notifyListeners();

    await saveSettings();
  }

  void toggleFreeModels(bool value) {
    showFreeOnly = value;

    if (selectedModel != null &&
        !visibleModels.any(
          (m) => m.id == selectedModel!.id,
        )) {
      selectedModel =
          visibleModels.isNotEmpty
              ? visibleModels.first
              : null;
    }

    notifyListeners();
  }

  Future<void> selectModel(
      AIModel? model) async {
    if (model == null) return;

    selectedModel = model;

    await SecureStorageService
        .saveSelectedModel(
      provider: providerType,
      model: model.id,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    apiKeyController.dispose();
    ollamaUrlController.dispose();
    super.dispose();
  }
}