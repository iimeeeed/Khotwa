import 'package:khotwa/backend/db/seekeraplication_table.dart';
import 'package:khotwa/backend/models/seeker_application.dart';
import 'package:khotwa/backend/repository/repository_base.dart';

class SeekerApplicationRepository implements RepositoryBase<SeekerApplication> {
  final SeekerApplicationTable seekerApplicationTable =
      SeekerApplicationTable();

  @override
  Future<List<Map<String, dynamic>>> customQuery(String sql,
      [List? arguments]) async {
    return await seekerApplicationTable.customQuery(sql, arguments);
  }

  @override
  Future<bool> delete(String whereClause, List whereArgs) async {
    try {
      final result =
          await seekerApplicationTable.delete(whereClause, whereArgs);
      return result > 0; // Return true if rows were deleted
    } catch (e) {
      print('Error deleting data: $e');
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      return await seekerApplicationTable.getAll();
    } catch (e) {
      print('Error getting all records: $e');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    try {
      return await seekerApplicationTable.getById(id);
    } catch (e) {
      print('Error getting record by ID: $e');
      return null;
    }
  }

  @override
  Future<bool> insert(SeekerApplication data) async {
    try {
      print("Inserting SeekerApplication...");

      // Print the data to see if it's correct
      print('SeekerApplication data: ${data.toString()}');

      final dataMap = data.toMap();
      print('Converted to map: $dataMap');

      final result = await seekerApplicationTable.insert(dataMap);
      print('Insert result: $result');

      return result > 0;
    } catch (e) {
      print('Error inserting data: $e');
      return false;
    }
  }

  @override
  Future<bool> update(
      Map<String, dynamic> data, String whereClause, List whereArgs) async {
    try {
      final result =
          await seekerApplicationTable.update(data, whereClause, whereArgs);
      return result > 0; // Return true if rows were updated
    } catch (e) {
      print('Error updating data: $e');
      return false;
    }
  }
}
