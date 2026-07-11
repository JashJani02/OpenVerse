import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/provider_type.dart';

class SecureStorageService {
  SecureStorageService._();

  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static const _apiKey = 'openrouter_api_key';

  static const _provider = 'provider_type';

  static const _ollamaUrl = 'ollama_base_url';

  static const _openRouterModel =
      'selected_openrouter_model';

  static const _ollamaModel =
      'selected_ollama_model';

  /*
  ------------------------
  API KEY
  ------------------------
  */

  static Future<void> saveApiKey(
    String apiKey,
  ) async {
    await _storage.write(
      key: _apiKey,
      value: apiKey,
    );
  }

  static Future<String?> getApiKey() async {
    return await _storage.read(
      key: _apiKey,
    );
  }

  static Future<void> deleteApiKey() async {
    await _storage.delete(
      key: _apiKey,
    );
  }

  /*
  ------------------------
  PROVIDER
  ------------------------
  */

  static Future<void> saveProvider(
    ProviderType provider,
  ) async {
    await _storage.write(
      key: _provider,
      value: provider.storageKey,
    );
  }

  static Future<ProviderType> getProvider() async {
    final value = await _storage.read(
      key: _provider,
    );

    return ProviderTypeExtension.fromStorage(
      value,
    );
  }

  /*
  ------------------------
  OLLAMA URL
  ------------------------
  */

  static Future<void> saveOllamaUrl(
    String url,
  ) async {
    await _storage.write(
      key: _ollamaUrl,
      value: url,
    );
  }

  static Future<String?> getOllamaUrl() async {
    return await _storage.read(
      key: _ollamaUrl,
    );
  }

  /*
  ------------------------
  MODEL
  ------------------------
  */

  static Future<void> saveSelectedModel({
    required ProviderType provider,
    required String model,
  }) async {
    await _storage.write(
      key: provider == ProviderType.openRouter
          ? _openRouterModel
          : _ollamaModel,
      value: model,
    );
  }

  static Future<String?> getSelectedModel(
    ProviderType provider,
  ) async {
    return await _storage.read(
      key: provider == ProviderType.openRouter
          ? _openRouterModel
          : _ollamaModel,
    );
  }
}