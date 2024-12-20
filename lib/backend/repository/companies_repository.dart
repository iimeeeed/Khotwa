import '../db/db_helper.dart';
import '../db/db_base.dart';
import 'repository_base.dart';
import '../models/company.dart';

class CompaniesRepository implements RepositoryBase<Company> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Future<bool> insert(Company data) async {
    final Map<String, dynamic> companyData = data.toMap();
    return await _dbHelper.insertRecord('companies', companyData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _dbHelper.getRecords('companies');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _dbHelper.getRecordById('companies', id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.updateRecord('companies', data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.deleteRecord('companies', whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _dbHelper.rawQuery(sql, arguments);
  }
}
