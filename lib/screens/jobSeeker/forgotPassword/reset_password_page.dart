import 'package:flutter/material.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'success_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isPasswordVisible = true;
  bool _isPasswordVisibleConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F2),
      appBar: AppBar(
        title: const Icon(Icons.arrow_back_ios),
        backgroundColor: const Color(0xFFEFF3F2),
        automaticallyImplyLeading: false,
        actions: const [KhotwaLogo()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontFamily: 'Khmer MN',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              const Text(
                'Enter your new password and confirm the new password to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 14),
              SizedBox(
                height: 109,
                width: 142,
                child: Image.asset(
                  'assets/forgotpassword1.png',
                  width: 160,
                  height: 110,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 14),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(!_isPasswordVisible ? Icons.visibility : Icons.visibility_off,),
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    labelText: 'New password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 45,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  obscureText: _isPasswordVisibleConfirm,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(!_isPasswordVisibleConfirm ? Icons.visibility : Icons.visibility_off,),
                      onTap: () {
                        setState(() {
                          _isPasswordVisibleConfirm = !_isPasswordVisibleConfirm;
                        });
                      },
                    ),
                    labelText: 'Confirm new password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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
                      MaterialPageRoute(
                          builder: (context) => const SuccessPage()),
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
