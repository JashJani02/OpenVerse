import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _apiKeyKey = 'openrouter_api_key';
  static const String _selectedModel= 'selected_model';

  static Future<void> saveSelectedModel(String modelId) async {
  await _storage.write(
    key: _selectedModel,
    value: modelId,
  );
}

static Future<String?> getSelectedModel() async {
  return await _storage.read(
    key: _selectedModel,
  );
}

  static Future<void> saveApiKey(String apiKey) async {
    await _storage.write(
      key: _apiKeyKey,
      value: apiKey,
    );
  }

  static Future<String?> getApiKey() async {
    return await _storage.read(
      key: _apiKeyKey,
    );
  }

  static Future<void> deleteApiKey() async {
    await _storage.delete(
      key: _apiKeyKey,
    );
  }
}