import './db_base.dart';
import './db_helper.dart';

class AuthService {
  final DBBaseTable _usersTable = UsersTable();
  final DBBaseTable _companiesTable = CompaniesTable();

  Future<Map<String, dynamic>?> signIn(String email, String password, bool isCompany) async {
    try {
      final DBBaseTable table = isCompany ? _companiesTable : _usersTable;

      List<Map<String, dynamic>> result = await table.rawQuery(
        'SELECT * FROM ${table.db_table} WHERE email = ? AND password = ?',
        [email, password],
      );

      if (result.isNotEmpty) {
        return result.first;
      }
      return null;
    } catch (e, stacktrace) {
      print('SignIn Error: $e --> $stacktrace');
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
      final DBBaseTable table = isCompany ? _companiesTable : _usersTable;

      Map<String, dynamic> data = {
        'email': email,
        'password': password,
        ...additionalData,
      };

      await table.insertRecord(data);
      return true;
    } catch (e, stacktrace) {
      print('SignUp Error: $e --> $stacktrace');
      return false;
    }
  }
}
