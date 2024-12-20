import '../db/companies_table.dart';
import 'repository_base.dart';
import '../models/company.dart';


class CompaniesRepository implements RepositoryBase<Company> {
  final CompaniesTable company = CompaniesTable();

  @override
  Future<bool> insert(Company data) async {
    final Map<String, dynamic> companyData = data.toMap();
    return await company.insertRecord(companyData);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return await company.getRecords();
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    return await company.getRecordById( id);
  }

  @override
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    return await company.updateRecord( data, whereClause, whereArgs);
  }

  @override
  Future<bool> delete(String whereClause, List<dynamic> whereArgs) async {
    return await company.deleteRecord( whereClause, whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]) async {
    return await company.rawQuery(sql, arguments);
  }
}
