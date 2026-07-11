import 'provider_type.dart';

class ProviderConfig {
  final ProviderType providerType;

  final String? apiKey;
  final String? baseUrl;

  const ProviderConfig({required this.providerType, this.apiKey, this.baseUrl});

  ProviderConfig copyWith({
    ProviderType? providerType,
    String? apiKey,
    String? baseUrl,
  }) {
    return ProviderConfig(
      providerType: providerType ?? this.providerType,
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}
