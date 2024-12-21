import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _dbName = 'app_database.db';
  static const _dbVersion = 1;

  // Singleton instance
  static final DBHelper instance = DBHelper._privateConstructor();
  DBHelper._privateConstructor();

  // Database instance
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE companies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name TEXT NOT NULL,
        company_industry TEXT NOT NULL,
        company_size TEXT,
        company_location TEXT,
        company_email TEXT UNIQUE NOT NULL,
        company_phone TEXT,
        company_website TEXT,
        company_logo TEXT,
        company_description TEXT,
        trade_register_number TEXT UNIQUE NOT NULL,
        tax_identification_number TEXT UNIQUE NOT NULL,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    await db.execute('''
      CREATE TABLE job_seekers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        job_seeker_email TEXT UNIQUE NOT NULL,
        job_seeker_phone TEXT,
        job_seeker_address TEXT,
        job_seeker_password TEXT NOT NULL,
        about_me TEXT,
        profile_picture TEXT,
        interests TEXT,
        job_types TEXT,
        job_preferences TEXT,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    await db.execute('''
      CREATE TABLE education_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_seeker_id INTEGER NOT NULL,
        institution_name TEXT NOT NULL,
        program_details TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE professional_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_seeker_id INTEGER NOT NULL,
        job_title TEXT NOT NULL,
        job_details TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT,
        is_current_job INTEGER DEFAULT 0,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE jobs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_title TEXT NOT NULL,
        job_description TEXT,
        job_category TEXT NOT NULL,
        job_sub_category TEXT,
        job_location TEXT,
        job_address TEXT,
        job_type TEXT NOT NULL,
        salary_lower_bound REAL,
        salary_upper_bound REAL,
        job_facilities TEXT,
        job_responsibilities TEXT,
        job_requirements TEXT,
        company_id INTEGER NOT NULL,
        created_at TEXT DEFAULT (datetime('now')),
        job_status TEXT DEFAULT 'open',
        FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE applications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_id INTEGER NOT NULL,
        job_seeker_id INTEGER NOT NULL,
        application_status TEXT DEFAULT 'pending',
        applied_at TEXT DEFAULT (datetime('now')),
        FOREIGN KEY (job_id) REFERENCES jobs (id) ON DELETE CASCADE,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      )
    ''');
  }

  // Insert operation
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Query operation
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Update operation
  Future<int> update(String table, Map<String, dynamic> row, String whereClause, List<dynamic> whereArgs) async {
    Database db = await instance.database;
    return await db.update(table, row, where: whereClause, whereArgs: whereArgs);
  }

  // Delete operation
  Future<int> delete(String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await instance.database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }

  // Custom query
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    Database db = await instance.database;
    return await db.rawQuery(sql, arguments);
  }

  // Close database
  Future<void> close() async {
    Database db = await instance.database;
    return db.close();
  }
}
