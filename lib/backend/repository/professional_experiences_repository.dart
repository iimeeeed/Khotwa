
import '../db/professional_experiences_table.dart';
import 'repository_base.dart';
import '../models/professional_experience.dart';


class ProfessionalExperiencesRepository implements RepositoryBase<ProfessionalExperience> {
  final ProfessionalExperiencesTable professionalExp = ProfessionalExperiencesTable();

  @override
  Future<bool> insert(ProfessionalExperience data) async {
    final Map<String, dynamic> experienceData = data.toMap();
    return await professionalExp.insertRecord( experienceData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await professionalExp.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await professionalExp.getRecordById( id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await professionalExp.updateRecord( data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await professionalExp.deleteRecord( whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await professionalExp.rawQuery(sql, arguments);
  }
}
