import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'khotwa_db_tables.dart';

class DBHelper {
  static const _database_name = 'khotwa_database55.db';  
  static const _database_version = 56;
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

  static Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'khotwa.db'); // or whatever your db name is
    await databaseFactory.deleteDatabase(path);
  }

  // Open the database or create it if it doesn't exist
  static Future<Database> getDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'khotwa.db');

      // Uncomment the next line temporarily to delete the database
      // await deleteDatabase();

      if (Platform.isWindows || Platform.isLinux) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      if (database != null) {
        return database!;
      }

      database = openDatabase(
        path,
        version: 2,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE job_seekers (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              full_name TEXT,
              job_seeker_email TEXT,
              job_seeker_password TEXT,
              job_preferences TEXT,
              job_type_preferences TEXT,
              job_location_preferences TEXT,
              created_at TEXT
            )
          ''');

          for (var item in sql_tables_codes) {
            await db.execute(item);
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion == 1) {
            var table = await db.query('pragma_table_info("job_seekers")');
            var columns = table.map((e) => e['name'].toString()).toList();

            if (!columns.contains('job_preferences')) {
              await db.execute('ALTER TABLE job_seekers ADD COLUMN job_preferences TEXT');
            }
            if (!columns.contains('job_type_preferences')) {
              await db.execute('ALTER TABLE job_seekers ADD COLUMN job_type_preferences TEXT');
            }
            if (!columns.contains('job_location_preferences')) {
              await db.execute('ALTER TABLE job_seekers ADD COLUMN job_location_preferences TEXT');
            }
            if (!columns.contains('created_at')) {
              await db.execute('ALTER TABLE job_seekers ADD COLUMN created_at TEXT');
            }
          }
        },
      );
      return database!;
    } catch (e) {
      print('Database Error: $e');
      rethrow;
    }
  }
}
