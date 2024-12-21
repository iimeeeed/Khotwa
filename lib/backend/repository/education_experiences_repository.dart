import '../db/education_experiences_table.dart';
import 'repository_base.dart';
import '../models/education_experience.dart';

class EducationExperiencesRepository implements RepositoryBase<EducationExperience> {
  final EducationExperiencesTable educationExp = EducationExperiencesTable();

  @override
  Future<bool> insert(EducationExperience data) async {
    final Map<String, dynamic> educationData = data.toMap();
    return await educationExp.insertRecord( educationData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await educationExp.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await educationExp.getRecordById( id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await educationExp.updateRecord( data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await educationExp.deleteRecord( whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await educationExp.rawQuery(sql, arguments);
  }
}
