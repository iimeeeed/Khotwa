import '../db/job_seekers_table.dart';
import 'repository_base.dart';
import '../models/job_seeker.dart';

class JobSeekersRepository implements RepositoryBase<JobSeeker> {
  final JobSeekersTable jobSeeker = JobSeekersTable();

  @override
  Future<bool> insert(JobSeeker data) async {
    final Map<String, dynamic> jobSeekerData = data.toMap(); // Convert to a map
    return await jobSeeker.insertRecord(jobSeekerData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await jobSeeker.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await jobSeeker.getRecordById(id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await jobSeeker.updateRecord(data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await jobSeeker.deleteRecord(whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await jobSeeker.rawQuery(sql, arguments);
  }

  Future<int?> getIdByEmail(String email) async {
    return await jobSeeker.getIdByEmail(email);
  }
}
