import '../supabase/job_preferences_service.dart';

class JobPreferencesRepository {
  final JobPreferencesService _preferencesService = JobPreferencesService();

  Future<bool> updatePreferences({
    required String email,
    required List<String> jobPreferences,
    required List<String> jobTypePreferences,
    required List<String> jobLocationPreferences,
  }) async {
    return await _preferencesService.updateJobSeekerPreferences(
      email: email,
      jobPreferences: jobPreferences,
      jobTypePreferences: jobTypePreferences,
      jobLocationPreferences: jobLocationPreferences,
    );
  }

  Future<Map<String, List<String>>?> getPreferences(String email) async {
    return await _preferencesService.getJobSeekerPreferences(email);
  }

  Future<bool> hasSetPreferences(String email) async {
    return await _preferencesService.hasSetPreferences(email);
  }
} 