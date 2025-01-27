import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class SupabaseAuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<Map<String, dynamic>?> signIn(String email, String password, bool isCompany) async {
    try {
      print('Attempting to sign in with email: $email');
      
      // First check if user exists
      final String table = isCompany ? 'companies' : 'job_seekers';
      final String emailField = isCompany ? 'company_user_email' : 'job_seeker_email';
      final String passwordField = isCompany ? 'company_user_password' : 'job_seeker_password';

      // First just check if the email exists
      final List<dynamic> emailCheck = await _client
          .from(table)
          .select()
          .eq(emailField, email);
      
      print('Email check results: ${emailCheck.length} users found');
      
      if (emailCheck.isEmpty) {
        print('No user found with this email');
        return null;
      }

      // Now check with password
      final List<dynamic> data = await _client
          .from(table)
          .select()
          .eq(emailField, email)
          .eq(passwordField, password);
      
      print('Password check results: ${data.length} users found');

      if (data.isNotEmpty) {
        print('User found, attempting Supabase auth');
        try {
          await _client.auth.signInWithPassword(
            email: email,
            password: password,
          );
          print('Supabase auth successful');
          return data.first;
        } catch (authError) {
          print('Supabase auth failed: $authError');
          return null;
        }
      } else {
        print('Password incorrect');
        return null;
      }
    } catch (e) {
      print('SignIn Error: $e');
      return null;
    }
  }

  Future<bool> updateJobSeekerPreferences({
    required String email,
    required String jobPreferences,
    required String jobTypePreferences,
    required String jobLocationPreferences,
  }) async {
    try {
      await _client.from('job_seekers')
          .update({
            'job_preferences': jobPreferences,
            'job_type_preferences': jobTypePreferences,
            'job_location_preferences': jobLocationPreferences,
          })
          .eq('job_seeker_email', email);
      return true;
    } catch (e) {
      print('Update Preferences Error: $e');
      return false;
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
    try {
      print('Attempting to sign up user with email: $email');
      
      // Check if user already exists
      final existingUsers = await _client
          .from('job_seekers')
          .select()
          .eq('job_seeker_email', email);
      
      if (existingUsers.isNotEmpty) {
        print('User already exists in database');
        return -1;
      }

      print('Creating user in database');
      // First create the user in our database table
      final data = await _client.from('job_seekers').insert({
        'full_name': fullName,
        'job_seeker_email': email,
        'job_seeker_password': password,
        'job_preferences': jobPreferences,
        'job_type_preferences': jobTypePreferences,
        'job_location_preferences': jobLocationPreferences,
        'created_at': DateTime.now().toIso8601String(),
      }).select('id').single();

      print('Creating Supabase auth user');
      // Then create the auth user
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        },
      );

      print('Signing in user');
      // Sign in immediately
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      print('Signup complete, returning ID: ${data['id']}');
      return data['id'];
    } catch (e) {
      print('SignUp Error: $e');
      return -1;
    }
  }

  // Helper method to check database directly
  Future<void> debugCheckUser(String email) async {
    try {
      final users = await _client
          .from('job_seekers')
          .select()
          .eq('job_seeker_email', email);
      
      print('Debug - Found users: $users');
    } catch (e) {
      print('Debug check error: $e');
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<bool> isAuthenticated() async {
    return _client.auth.currentUser != null;
  }
} 