import 'package:khotwa/backend/db/db_helper.dart';

import 'db_base.dart';

class JobsTable extends DBBaseTable {
  @override
  String get db_table => 'jobs';  // Table name

  // You can add custom methods for the `jobs` table if necessary

  // Custom method to fetch jobs by company ID
  Future<List<Map<String, dynamic>>> getJobsByCompanyId(int companyId) async {
    try {
      final db = await DBHelper.getDatabase();
      return await db.query(
        db_table,
        where: 'company_id = ?',
        whereArgs: [companyId],
      );
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return [];
    }
  }
}
