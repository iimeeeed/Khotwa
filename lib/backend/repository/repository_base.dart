import 'dart:async';

abstract class RepositoryBase<T> {
  Future<bool> insert(T data);
  Future<List<Map<String, dynamic>>> getAll();
  Future<Map<String, dynamic>?> getById(int id);
  Future<bool> update(Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs);
  Future<bool> delete(String whereClause, List<dynamic> whereArgs);
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<dynamic>? arguments]);
}
