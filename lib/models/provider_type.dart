enum ProviderType {
  openRouter,
  ollama,
}

extension ProviderTypeExtension on ProviderType {
  String get storageKey {
    switch (this) {
      case ProviderType.openRouter:
        return 'openrouter';
      case ProviderType.ollama:
        return 'ollama';
    }
  }

  String get displayName {
    switch (this) {
      case ProviderType.openRouter:
        return 'OpenRouter';
      case ProviderType.ollama:
        return 'Ollama';
    }
  }

  static ProviderType fromStorage(String? value) {
    switch (value) {
      case 'ollama':
        return ProviderType.ollama;

      case 'openrouter':
      default:
        return ProviderType.openRouter;
    }
  }
}