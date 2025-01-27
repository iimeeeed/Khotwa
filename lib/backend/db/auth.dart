import '../supabase/auth_service.dart';

class AuthService {
  final SupabaseAuthService _supabaseAuth = SupabaseAuthService();

  Future<Map<String, dynamic>?> signIn(String email, String password, bool isCompany) async {
    try {
      final result = await _supabaseAuth.signIn(email, password, isCompany);
      print('AuthService signIn result: $result'); // Debug print
      return result;
    } catch (e) {
      print('AuthService signIn error: $e'); // Debug print
      rethrow;
    }
  }

  Future<int?> signUpJobseeker({
    required String fullName,
    required String email,
    required String password,
    String? jobPreferences,
    String? jobTypePreferences,
    String? jobLocationPreferences,
  }) async {
    return await _supabaseAuth.signUpJobseeker(
      fullName: fullName,
      email: email,
      password: password,
      jobPreferences: jobPreferences,
      jobTypePreferences: jobTypePreferences,
      jobLocationPreferences: jobLocationPreferences,
    );
  }

  Future<bool> updateJobSeekerPreferences({
    required String email,
    required String jobPreferences,
    required String jobTypePreferences,
    required String jobLocationPreferences,
  }) async {
    return await _supabaseAuth.updateJobSeekerPreferences(
      email: email,
      jobPreferences: jobPreferences,
      jobTypePreferences: jobTypePreferences,
      jobLocationPreferences: jobLocationPreferences,
    );
  }
}
