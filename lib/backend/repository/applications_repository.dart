import '../db/db_helper.dart';
import '../db/db_base.dart';
import 'repository_base.dart';
import '../models/application.dart';

class ApplicationsRepository implements RepositoryBase<Application> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Future<bool> insert(Application data) async {
    final Map<String, dynamic> applicationData = data.toMap();
    return await _dbHelper.insertRecord('applications', applicationData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _dbHelper.getRecords('applications');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _dbHelper.getRecordById('applications', id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.updateRecord('applications', data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.deleteRecord('applications', whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _dbHelper.rawQuery(sql, arguments);
  }
}
