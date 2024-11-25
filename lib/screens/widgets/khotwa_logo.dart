import 'package:flutter/material.dart';

class KhotwaLogo extends StatelessWidget {
  const KhotwaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Text("Khotwa",style: TextStyle(
        fontFamily: "Khmer MN",
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B4174),
      ),)
    );
  }
}

