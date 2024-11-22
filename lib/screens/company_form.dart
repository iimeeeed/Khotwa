import 'package:flutter/material.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Company Name"),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your company name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Email"),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Password"),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter your password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
