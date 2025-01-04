import 'package:khotwa/backend/models/job_seeker.dart';
import 'package:khotwa/backend/repository/companies_repository.dart';
import 'package:khotwa/backend/repository/job_seekers_repository.dart';
import 'package:khotwa/backend/repository/repository_base.dart';


class AuthService {
  final JobSeekersRepository _jobSeekersTable =  JobSeekersRepository();
  final CompaniesRepository _companiesTable = CompaniesRepository();

  Future<Map<String, dynamic>?> signIn(String email, String password, bool isCompany) async {
    try {
      final RepositoryBase table = isCompany ? _companiesTable : _jobSeekersTable;

      String query = (isCompany)? "SELECT * FROM ${_companiesTable.company.db_table} WHERE company_user_email = ? AND company_user_password = ?" :
      "SELECT * FROM ${_jobSeekersTable.jobSeeker.db_table} WHERE job_seeker_email = ? AND job_seeker_password = ?" ;

      List<Map<String, dynamic>> result = await table.customQuery(
        query,
        [email, password],
      );

      if (result.isNotEmpty) {
        return result.first;
      }
      return null;
    } catch (e, stacktrace) {
      print('SignIn Error: $e --> $stacktrace');
      return null;
    }
  }

  Future<int?> signUpJobseeker({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      JobSeeker jobSeeker = JobSeeker(fullName: fullName, email: email, password: password);
      
      await _jobSeekersTable.insert(jobSeeker);
      int? id = await _jobSeekersTable.getIdByEmail(email);
      
      return id;
    } catch (e, stacktrace) {
      print('SignUp Error: $e --> $stacktrace');
      return -1;
    }
  }
}
