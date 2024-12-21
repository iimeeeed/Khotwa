import '../db/db_helper.dart';

class AuthService {
  final DBHelper _dbHelper = DBHelper.instance;

  Future<Map<String, dynamic>?> signIn(String email, String password, bool isCompany) async {
    try {
      String table = isCompany ? 'companies' : 'job_seekers';
      String emailField = isCompany ? 'company_email' : 'job_seeker_email';
      String passwordField = isCompany ? 'company_password' : 'job_seeker_password';

      List<Map<String, dynamic>> result = await _dbHelper.rawQuery(
        'SELECT * FROM $table WHERE $emailField = ? AND $passwordField = ?',
        [email, password]
      );

      if (result.isNotEmpty) {
        return result.first;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required bool isCompany,
    required Map<String, dynamic> additionalData,
  }) async {
    try {
      String table = isCompany ? 'companies' : 'job_seekers';
      
      Map<String, dynamic> data = {
        if (isCompany) ...{
          'company_email': email,
          'company_password': password,
          ...additionalData,
        } else ...{
          'job_seeker_email': email,
          'job_seeker_password': password,
          ...additionalData,
        }
      };

      await _dbHelper.insert(table, data);
      return true;
    } catch (e) {
      return false;
    }
  }
}