class AttractionModel {
  final int id;
  final String name;
  final String description;

  AttractionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
    );
  }
}