import 'package:sqflite/sqflite.dart';

import 'db_base.dart';
import 'db_helper.dart';

class SeekerApplicationTable extends DBBaseTable {
  @override
  String get db_table => 'seeker_application'; // Table name

  // Insert a new seeker application
  Future<int> insert(Map<String, dynamic> data) async {
    print("Inserting data..."); // Print when the insert method is called
    final db = await DBHelper.getDatabase();

    // Check if db is null or not
    print("Database: $db");

    try {
      // Print the data being inserted
      print("Data being inserted: $data");

      final result = await db.insert(
        db_table,
        data,
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Replace in case of conflict
      );

      // Print result of insert
      print("Insert result: $result");

      return result;
    } catch (e) {
      print("Error inserting data: $e");
      return -1; // Return an error value if the insert fails
    }
  }

  // Retrieve all seeker applications
  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await DBHelper.getDatabase();
    return await db.query(db_table);
  }

  // Retrieve a seeker application by ID
  Future<Map<String, dynamic>?> getById(int id) async {
    final db = await DBHelper.getDatabase();
    final result = await db.query(
      db_table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update a seeker application
  Future<int> update(Map<String, dynamic> data, String whereClause,
      List<dynamic> whereArgs) async {
    final db = await DBHelper.getDatabase();
    return await db.update(
      db_table,
      data,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  // Delete a seeker application
  Future<int> delete(String whereClause, List<dynamic> whereArgs) async {
    final db = await DBHelper.getDatabase();
    return await db.delete(
      db_table,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  // Custom query execution
  Future<List<Map<String, dynamic>>> customQuery(String sql,
      [List<dynamic>? arguments]) async {
    final db = await DBHelper.getDatabase();
    return await db.rawQuery(sql, arguments);
  }
}
