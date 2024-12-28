import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'khotwa_db_tables.dart';

class DBHelper {
  static const _database_name = 'khotwa_database55.db';  
  static const _database_version = 55;
  static Future<Database>? database;

  // Add SQL table creation codes to the list
  static List<String> sql_tables_codes = [
    DBTables.companiesTableSql,  
    DBTables.jobSeekersTableSql,
    DBTables.educationExperiencesTableSql,
    DBTables.professionalExperiencesTableSql,
    DBTables.jobsTableSql,
    DBTables.applicationsTableSql
  ];

  // Singleton instance for DBHelper
  static final DBHelper instance = DBHelper._privateConstructor();

  // Private named constructor for the singleton
  DBHelper._privateConstructor();

  // Open the database or create it if it doesn't exist
  static Future<Database> getDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    if (database != null) {
      return database!;
    }

    database = openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (database, version) async {
        for (var item in sql_tables_codes) {
          await database.execute(item);
        }
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrades (if necessary)
      },
    );
    return database!;
  }
}
