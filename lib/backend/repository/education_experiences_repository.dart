import '../db/db_helper.dart';
import '../db/db_base.dart';
import 'repository_base.dart';
import '../models/education_experience.dart';

class EducationExperiencesRepository implements RepositoryBase<EducationExperience> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Future<bool> insert(EducationExperience data) async {
    final Map<String, dynamic> educationData = data.toMap();
    return await _dbHelper.insertRecord('education_experiences', educationData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _dbHelper.getRecords('education_experiences');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _dbHelper.getRecordById('education_experiences', id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.updateRecord('education_experiences', data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.deleteRecord('education_experiences', whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _dbHelper.rawQuery(sql, arguments);
  }
}
