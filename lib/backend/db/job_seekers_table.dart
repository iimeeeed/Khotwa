import 'package:khotwa/backend/db/db_helper.dart';

import 'db_base.dart';

class JobSeekersTable extends DBBaseTable {
  @override
  String get db_table => 'job_seekers';  // Table name

  // You can add custom methods for the `job_seekers` table if necessary

  // Method to get the ID of a record by email
  Future<int?> getIdByEmail(String email) async {
    try {
      final db = await DBHelper.getDatabase();
      var result = await db.query(
        db_table,
        columns: ['id'], 
        where: 'job_seeker_email = ?', 
        whereArgs: [email],
      );
      if (result.isNotEmpty) {
        return result.first['id'] as int; // Return the ID if found
      } else {
        return null; 
      }
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return null; 
    }
  }
}
