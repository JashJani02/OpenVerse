import '../../../models/provider_config.dart';
import '../../../models/provider_type.dart';

import 'ai_provider.dart';
import 'ollama_provider.dart';
import 'openrouter_provider.dart';

class ProviderFactory {
  const ProviderFactory._();

  static AIProvider create(
    ProviderConfig config,
  ) {
    switch (config.providerType) {
      case ProviderType.openRouter:
        return OpenRouterProvider();

      case ProviderType.ollama:
        return OllamaProvider();
    }
  }
}