import 'package:flutter/material.dart';

class KhotwaLogo extends StatelessWidget {
  const KhotwaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Image.asset("assets/Khotwa.png"),
    );
  }
}

