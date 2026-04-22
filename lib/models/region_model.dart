class RegionModel {
  final int id;
  final String name;
  final String description;

  RegionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
    );
  }
}