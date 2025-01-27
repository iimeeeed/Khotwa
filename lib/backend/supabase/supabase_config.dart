import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String SUPABASE_URL = 'https://jqzqcadpqcalebzdwtdu.supabase.co';            // supabase project url
  static const String SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxenFjYWRwcWNhbGViemR3dGR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYyNTY2NjUsImV4cCI6MjA1MTgzMjY2NX0.JXSSU6VF1dnZvy1FT4usM23Kw_f-jyFDbSdFELdmnUk';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_ANON_KEY,
    );
  }
} 