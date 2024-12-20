import '../db/applications_table.dart';
import 'repository_base.dart';
import '../models/application.dart';

class ApplicationsRepository implements RepositoryBase<Application> {
  final ApplicationsTable applications = ApplicationsTable();

  @override
  Future<bool> insert(Application data) async {
    final Map<String, dynamic> applicationData = data.toMap();
    return await applications.insertRecord(applicationData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await applications.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await applications.getRecordById(id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await applications.updateRecord(data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await applications.deleteRecord(whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await applications.rawQuery(sql, arguments);
  }
}
