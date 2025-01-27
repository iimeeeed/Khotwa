import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class JobSeekersService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<Map<String, dynamic>?> getJobseekerById(int id) async {
    try {
      final data = await _client
          .from('job_seekers')
          .select()
          .eq('id', id)
          .single();
      return data;
    } catch (e) {
      print('Get Jobseeker Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getJobseekerByEmail(String email) async {
    try {
      final data = await _client
          .from('job_seekers')
          .select()
          .eq('job_seeker_email', email)
          .single();
      return data;
    } catch (e) {
      print('Get Jobseeker Error: $e');
      return null;
    }
  }
} 