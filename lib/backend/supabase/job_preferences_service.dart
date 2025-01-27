import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class JobPreferencesService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<bool> updateJobSeekerPreferences({
    required String email,
    required List<String> jobPreferences,
    required List<String> jobTypePreferences,
    required List<String> jobLocationPreferences,
  }) async {
    try {
      // Convert lists to comma-separated strings for storage
      final jobPrefsString = jobPreferences.join(',');
      final jobTypePrefsString = jobTypePreferences.join(',');
      final jobLocationPrefsString = jobLocationPreferences.join(',');

      await _client.from('job_seekers').update({
        'job_preferences': jobPrefsString,
        'job_type_preferences': jobTypePrefsString,
        'job_location_preferences': jobLocationPrefsString,
      }).eq('job_seeker_email', email);

      return true;
    } catch (e) {
      print('Update Job Preferences Error: $e');
      return false;
    }
  }

  Future<Map<String, List<String>>?> getJobSeekerPreferences(String email) async {
    try {
      final data = await _client
          .from('job_seekers')
          .select('job_preferences, job_type_preferences, job_location_preferences')
          .eq('job_seeker_email', email)
          .single();

      if (data != null) {
        return {
          'jobPreferences': (data['job_preferences'] as String?)?.split(',') ?? [],
          'jobTypePreferences': (data['job_type_preferences'] as String?)?.split(',') ?? [],
          'jobLocationPreferences': (data['job_location_preferences'] as String?)?.split(',') ?? [],
        };
      }
      return null;
    } catch (e) {
      print('Get Job Preferences Error: $e');
      return null;
    }
  }

  // Helper method to check if preferences are set
  Future<bool> hasSetPreferences(String email) async {
    try {
      final data = await _client
          .from('job_seekers')
          .select('job_preferences')
          .eq('job_seeker_email', email)
          .single();

      return data['job_preferences'] != null && data['job_preferences'].toString().isNotEmpty;
    } catch (e) {
      print('Check Preferences Error: $e');
      return false;
    }
  }
} 