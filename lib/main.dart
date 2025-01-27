import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/Signup.dart';
import 'backend/supabase/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  bool isLanding = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () { 
      setState(() {
        isLanding = false;
        isLoading = true;
      });

      Future.delayed(const Duration(milliseconds: 0), () {  
        setState(() {
          isLoading = false; 
        });
      });
    });
  }

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFEFF3F2),
        body: isLanding
            ? const Landing() 
            : isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1B4174))
                    ), 
                  )
                : const Signup(), 
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
