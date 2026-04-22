class PresidentModel {
  final int id;
  final String name;
  final String lastName;
  final String description;

  PresidentModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.description,
  });

  factory PresidentModel.fromJson(Map<String, dynamic> json) {
    return PresidentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      lastName: json['lastName'] ?? '',
      description: json['description'] ?? 'Sin descripción',
    );
  }
}