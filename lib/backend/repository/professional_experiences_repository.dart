import '../db/db_helper.dart';
import '../db/db_base.dart';
import 'repository_base.dart';
import '../models/professional_experience.dart';


class ProfessionalExperiencesRepository implements RepositoryBase<ProfessionalExperience> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Future<bool> insert(ProfessionalExperience data) async {
    final Map<String, dynamic> experienceData = data.toMap();
    return await _dbHelper.insertRecord('professional_experiences', experienceData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await _dbHelper.getRecords('professional_experiences');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await _dbHelper.getRecordById('professional_experiences', id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.updateRecord('professional_experiences', data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await _dbHelper.deleteRecord('professional_experiences', whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await _dbHelper.rawQuery(sql, arguments);
  }
}
