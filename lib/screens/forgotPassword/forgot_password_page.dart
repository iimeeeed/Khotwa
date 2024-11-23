import 'package:flutter/material.dart';
import 'package:khotwa/screens/forgotPassword/verify_code_page.dart';

class ForgotPasswordFlowScreen extends StatelessWidget {
  const ForgotPasswordFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView( // Allows the screen to scroll when necessary
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/Khotwa.png', 
                  width: 100,
                ),
              ),
              const SizedBox(height: 70),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Khmer MN',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4174),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'To reset your password, you need your email or mobile number that can be authenticated.',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/forgotpassword1.png', 
                width: 160,
                height: 110, 
                fit: BoxFit.contain, 
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans',
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your email here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4174),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VerifyCodePage()),
                    );
                  },
                  child: const Text(
                    'RESET PASSWORD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
