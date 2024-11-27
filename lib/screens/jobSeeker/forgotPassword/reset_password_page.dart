import 'package:flutter/material.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'success_page.dart';
import '../../../commons/constants.dart';

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
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        title: const Icon(Icons.arrow_back_ios),
        backgroundColor: AppColors.primaryBackgroundColor,
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
                  fontFamily: AppFonts.primaryFont,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackTextColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              const Text(
                'Enter your new password and confirm the new password to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 16,
                  color: AppColors.greyTextColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(!_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    labelText: 'New password',
                    labelStyle: const TextStyle(color: AppColors.greyTextColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 45),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  obscureText: _isPasswordVisibleConfirm,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(!_isPasswordVisibleConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          _isPasswordVisibleConfirm =
                              !_isPasswordVisibleConfirm;
                        });
                      },
                    ),
                    labelText: 'Confirm new password',
                    labelStyle: const TextStyle(color: AppColors.greyTextColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 7),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: AppColors.blueButtonColor,
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
