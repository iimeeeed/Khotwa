import '../db/jobs_table.dart';
import 'repository_base.dart';
import '../models/job.dart';

class JobsRepository implements RepositoryBase<Job> {
  final JobsTable jobs = JobsTable();

  @override
  Future<bool> insert(Job data) async {
    final Map<String, dynamic> jobData = data.toMap();
    return await jobs.insertRecord(jobData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await jobs.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await jobs.getRecordById(id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await jobs.updateRecord(data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await jobs.deleteRecord(whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await jobs.rawQuery(sql, arguments);
  }

  Future<List<Map<String, dynamic>>> getJobsByCompanyId(int companyId) async {
    return await jobs.getJobsByCompanyId(companyId);
  }
}
