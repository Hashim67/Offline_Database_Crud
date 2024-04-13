import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // Method to create tables in the database
  static Future<void> createTables(sql.Database database) async {
    try {
      await database.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
      ''');
      print('Table created successfully');
    } catch (e) {
      print('Error creating table: $e');
      throw Exception('Error creating table: $e');
    }
  }

  // Method to open the database
  static Future<sql.Database> db() async {
    try {
      final db = await sql.openDatabase(
        'app_database.db',
        version: 1,
        onCreate: (sql.Database db, int version) async {
          await createTables(db);
        },
      );
      print('Database opened successfully ${db}');
      return db;
    } catch (e) {
      print('Error opening database: $e');
      throw Exception('Error opening database: $e');
    }
  }


  // Method to store categories in the database
  static Future<void> storeCategories(List<DatabaseCategoryModel> categories) async {
  final db = await SQLHelper.db();
  try {
    final batch = db.batch();
    for (var category in categories) {
      batch.insert('categories', category.toMap());
    }
    print('Batch operations prepared successfully');
    final results = await batch.commit(noResult: true);
    print('Categories stored successfully');
    print('Results: $results');
  } catch (e) {
    print('Error storing categories: $e');
    throw Exception('Error storing categories: $e');
  }
}





// Method to get categories in the database
static Future<List<DatabaseCategoryModel>> getCategories() async {
  final db = await SQLHelper.db();
  try {
    final List<Map<String, dynamic>> categoryMapList = await db.query('categories', orderBy: 'creation_date DESC');
    print('Categories retrieved successfully');
    return categoryMapList.map((categoryMap) => DatabaseCategoryModel.fromMap(categoryMap)).toList();
  } catch (e) {
    print('Error getting categories: $e');
    throw Exception('Error getting categories: $e');
  }
}




  // Method to clear categories from the database
  static Future<void> clearCategories() async {
    final db = await SQLHelper.db();
    try {
      await db.delete('categories');
      print('Categories cleared successfully');
    } catch (e) {
      print('Error clearing categories: $e');
      throw Exception('Error clearing categories: $e');
    }
  }

  //////  Create Items //////

  // Method to create a new category in the database
  static Future<void> createCategory(DatabaseCategoryModel category) async {
    final db = await SQLHelper.db();
    try {
      await db.insert(
        'categories',
        category.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      print('Category created successfully');
    } catch (e) {
      print('Error creating category: $e');
      throw Exception('Error creating category: $e');
    }
  }


// Method to update a category in the database
  static Future<void> updateCategory(DatabaseCategoryModel category) async {
    final db = await SQLHelper.db();
    try {
      await db.update(
        'categories',
        category.toMap(),
        where: 'id = ?',
        whereArgs: [category.id],
      );
      print('Category updated successfully');
    } catch (e) {
      print('Error updating category: $e');
      throw Exception('Error updating category: $e');
    }
  }

  // Method to delete a category from the database
  static Future<void> deleteCategory(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(
        'categories',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Category deleted successfully');
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('Error deleting category: $e');
    }
  }

}

