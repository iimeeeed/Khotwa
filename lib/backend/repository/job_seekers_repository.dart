import '../db/job_seekers_table.dart';
import 'repository_base.dart';
import '../models/job_seeker.dart';

class JobSeekersRepository implements RepositoryBase<JobSeeker> {
  final JobSeekersTable _jobSeekersTable = JobSeekersTable();

  @override
  Future<bool> insert(JobSeeker data) async {
    final Map<String, dynamic> jobSeekerData = data.toMap(); // Convert to a map
    return await _jobSeekersTable.insertRecord(jobSeekerData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _jobSeekersTable.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _jobSeekersTable.getRecordById(id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _jobSeekersTable.updateRecord(data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _jobSeekersTable.deleteRecord(whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _jobSeekersTable.rawQuery(sql, arguments);
  }
}
