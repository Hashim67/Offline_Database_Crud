import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:developer';
class SQLHelper {
  // Method to create tables in the database
  static Future<void> createTables(sql.Database database) async {
    try {
      await database.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT
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
  await db.transaction((txn) async {
    var batch = txn.batch();
    for (var category in categories) {
      batch.insert('categories', category.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }
    var results = await batch.commit();
    log('Batch Results: $results');
    if (results.isNotEmpty) {
      print('Categories stored successfully');
    } else {
      print('No categories were stored');
    }
  }).catchError((e) {
    print('Error storing categories: $e');
    throw Exception('Error storing categories: $e');
  });
}


  // Method to get categories from the database
  static Future<List<DatabaseCategoryModel>> getCategories() async {
    final db = await SQLHelper.db();
    try {
      final List<Map<String, dynamic>> categoryMapList = await db.query('categories');
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




















// import 'dart:async';
// import 'dart:developer';

// import 'package:offline_database_crud/Api/Models/category_model.dart';
// import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// class SQLHelper {
//   // Method to create tables in the database
//  static Future<void> createTables(sql.Database database) async {
//   try {
//     await database.execute('''
//       CREATE TABLE IF NOT EXISTS categories (
//         id INTEGER PRIMARY KEY,
//         name TEXT,
//         description TEXT
        
//       )
//     ''');
//     print('Table created successfully');
//   } catch (e) {
//     print('Error creating table: $e');
//     throw Exception('Error creating table: $e');
//   }
// }

//   // Method to open the database
// static Future<sql.Database> db() async {
//   try {
//     final db = await sql.openDatabase(
//       'app_database.db',
//       version: 1,
//       onCreate: (sql.Database db, int version) async {
//         await createTables(db);
//       },
//     );
//     print('Database opened successfully ${db}');
//     return db;
//   } catch (e) {
//     print('Error opening database: $e');
//     throw Exception('Error opening database: $e');
//   }
// }

//   //Method to store categories in the database
// // static Future<void> storeCategories (List
// // <DatabaseCategoryModel> categories) async {
// // final db = await SQLHelper.db();
// // try {
// // final batch = db.batch();
// // for (var category in categories) {
// // print('Preparing to store category: ${category.toMap()}');
// // batch.insert('categories', category.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
// // }
// // await batch.commit(noResult: true);
// // print('Categories stored successfully');
// // } catch (e) {
// // print('Error storing categories: $e');
// // throw Exception('Error storing categories: $e');
// // }
// // }


// // Your existing imports and code...

// static Future<void> storeCategories(CategoryModel categories) async {
//   try {
//     final sql.Database database = await db(); // Open the database

//     // Insert each category into the 'categories' table
//     await Future.forEach(categories.data!, (CategoryModel category) async {
//       await database.insert(
//         'categories',
//         category.toMap(),
//         conflictAlgorithm: sql.ConflictAlgorithm.replace,
        
//       );
//       log('Stored Data >>> ${categories.data!}');
//     } as FutureOr Function(CategoryDatum element));

//     print('Categories stored successfully');
//   } catch (e) {
//     print('Error storing categories: $e');
//     throw Exception('Error storing categories: $e');
//   }
// }

// // Method to get categories in the database
// // static Future<List<DatabaseCategoryModel>> getCategories() async {
// //   final db = await SQLHelper.db();
// //   try {
// //     final List<Map<String, dynamic>> categoryMapList = await db.query('categories');
// //     print('Categories retrieved successfully');
// //     return categoryMapList.map((categoryMap) => DatabaseCategoryModel.fromMap(categoryMap)).toList();
// //   } catch (e) {
// //     print('Error getting categories: $e');
// //     throw Exception('Error getting categories: $e');
// //   }
// // }

// static Future<List
// <DatabaseCategoryModel>> getCategories() async {
// final db = await SQLHelper.db();
// try {
// final List<Map<String, dynamic>> categoryMapList = await db.query('categories');
// print('Executing query on database.');
// if (categoryMapList.isNotEmpty) {
// print('Categories retrieved from database: $categoryMapList');
// return categoryMapList.map((categoryMap) => DatabaseCategoryModel.fromMap(categoryMap)).toList();
// } else {
// print('No categories found in the database.');
// return [];
// }
// } catch (e) {
// print('Error getting categories from database: $e');
// throw Exception('Error getting categories from database: $e');
// }
// }


// // static Future<List<DatabaseCategoryModel>> getCategories() async {
// //   final db = await SQLHelper.db();
// //   try {
// //     final List<Map<String, dynamic>> categoryMapList = await db.query('categories');
// //     print('Categories retrieved successfully');
// //      print('Retrieved categoryMapList: $categoryMapList');
// //     return categoryMapList.map((categoryMap) => DatabaseCategoryModel.fromMap(categoryMap)).toList();
// //   } catch (e) {
// //     print('Error getting categories: $e');
// //     throw Exception('Error getting categories: $e');
// //   }
// // }



//   // Method to clear categories from the database
//   static Future<void> clearCategories() async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete('categories');
//       print('Categories cleared successfully');
//     } catch (e) {
//       print('Error clearing categories: $e');
//       throw Exception('Error clearing categories: $e');
//     }
//   }

//   //////  Create Items //////

//   // Method to create a new category in the database
//   static Future<void> createCategory(DatabaseCategoryModel category) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.insert(
//         'categories',
//         category.toMap(),
//         conflictAlgorithm: sql.ConflictAlgorithm.replace,
//       );
//       print('Category created successfully');
//     } catch (e) {
//       print('Error creating category: $e');
//       throw Exception('Error creating category: $e');
//     }
//   }


// // Method to update a category in the database
//   static Future<void> updateCategory(DatabaseCategoryModel category) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.update(
//         'categories',
//         category.toMap(),
//         where: 'id = ?',
//         whereArgs: [category.id],
//       );
//       print('Category updated successfully');
//     } catch (e) {
//       print('Error updating category: $e');
//       throw Exception('Error updating category: $e');
//     }
//   }

//   // Method to delete a category from the database
//   static Future<void> deleteCategory(int id) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete(
//         'categories',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//       print('Category deleted successfully');
//     } catch (e) {
//       print('Error deleting category: $e');
//       throw Exception('Error deleting category: $e');
//     }
//   }

// }

