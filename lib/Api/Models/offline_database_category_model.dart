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
      id: map['id'] ?? 0, // providing default value to avoid null issue
      name: map['name'] ?? '', // providing default value to avoid null issue
      description: map['description'] ?? '', // providing default value to avoid null issue
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'DatabaseCategoryModel{id: $id, name: "$name", description: "$description"}';
  }
}









// class DatabaseCategoryModel {
//   final int id; // Primary key
//   final String name;
//   final String description;

//   DatabaseCategoryModel({
//     required this.id,
//     required this.name,
//     required this.description,
//   });

//   factory DatabaseCategoryModel.fromMap(Map<String, dynamic> map) {
//     return DatabaseCategoryModel(
//       id: map['id'],
//       name: map['name'],
//       description: map['description'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//     };
//   }

//   toDatabaseModel() {}
// }