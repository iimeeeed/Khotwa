import '../db/db_helper.dart';
import '../db/db_base.dart';
import 'repository_base.dart';
import '../models/job.dart';

class JobsRepository implements RepositoryBase<Job> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Future<bool> insert(Job data) async {
    final Map<String, dynamic> jobData = data.toMap();
    return await _dbHelper.insertRecord('jobs', jobData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _dbHelper.getRecords('jobs');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _dbHelper.getRecordById('jobs', id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.updateRecord('jobs', data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.deleteRecord('jobs', whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _dbHelper.rawQuery(sql, arguments);
  }
}
