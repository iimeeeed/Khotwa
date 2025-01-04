import 'package:khotwa/backend/db/db_helper.dart';
import 'db_base.dart';

class CompaniesTable extends DBBaseTable {
  @override
  String get db_table => 'companies';  // Table name

  // You can add custom methods for the `companies` table if necessary

  // Method to get the ID of a record by email
  Future<int?> getIdByEmail(String email) async {
    try {
      final db = await DBHelper.getDatabase();
      var result = await db.query(
        db_table,
        columns: ['id'], 
        where: 'company_user_email = ?', 
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
