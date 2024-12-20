import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class DBBaseTable {
  // The table name should be overridden in each subclass
  String get db_table => throw UnimplementedError();

  // Insert operation
  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final db = await DBHelper.instance.database;
      await db.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return false;
    }
  }

  // Get all records from the table
  Future<List<Map<String, dynamic>>> getRecords() async {
    try {
      final db = await DBHelper.instance.database;
      var data = await db.query(db_table, orderBy: 'id DESC');
      return data;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return [];
    }
  }

  // Get a single record by its ID
  Future<Map<String, dynamic>?> getRecordById(int id) async {
    try {
      final db = await DBHelper.instance.database;
      var data = await db.query(db_table,
          where: 'id = ?',
          whereArgs: [id]);
      return data.isNotEmpty ? data.first : null;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return null;
    }
  }

  // Update operation
  Future<bool> updateRecord(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    try {
      final db = await DBHelper.instance.database;
      await db.update(db_table, data, where: whereClause, whereArgs: whereArgs);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return false;
    }
  }

  // Delete operation
  Future<bool> deleteRecord(String whereClause, List<dynamic> whereArgs) async {
    try {
      final db = await DBHelper.instance.database;
      await db.delete(db_table, where: whereClause, whereArgs: whereArgs);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return false;
    }
  }

  // Custom query (raw SQL)
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    try {
      final db = await DBHelper.instance.database;
      return await db.rawQuery(sql, arguments);
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return [];
    }
  }

  // Close database
  Future<void> close() async {
    try {
      final db = await DBHelper.instance.database;
      return await db.close();
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
  }
}



