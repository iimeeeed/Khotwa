import 'package:flutter/material.dart';
import 'screens/jobSeeker/loginJobSeeker.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLanding = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLanding = !isLanding;  
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLanding ? Landing() : LoginJobSeeker(),
      ),
    );
  }
}
