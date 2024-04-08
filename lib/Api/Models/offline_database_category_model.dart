class DatabaseCategoryModel {
  final int id; // Primary key
  final String name;
  final String description;

  DatabaseCategoryModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DatabaseCategoryModel.fromMap(Map<String, dynamic> map) {
    return DatabaseCategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}