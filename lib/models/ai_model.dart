class AIModel {
  final String id;
  final String name;
  final bool isFree;

  const AIModel({
    required this.id,
    required this.name,
    required this.isFree,
  });

  factory AIModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;

    return AIModel(
      id: id,
      name: json['name'] ?? id,
      isFree: id.endsWith(':free'),
    );
  }
}