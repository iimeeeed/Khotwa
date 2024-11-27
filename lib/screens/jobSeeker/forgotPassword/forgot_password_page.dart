import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobSeeker/forgotPassword/verify_code_page.dart';
import '../../../commons/khotwa_logo.dart';
import '../../jobSeeker/loginJobSeeker.dart';
import '../../../commons/constants.dart';

class ForgotPasswordFlowScreen extends StatefulWidget {
  const ForgotPasswordFlowScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordFlowScreen> createState() => _ForgotPasswordFlowScreenState();
}

class _ForgotPasswordFlowScreenState extends State<ForgotPasswordFlowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        actions: const [KhotwaLogo()],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: AppFonts.primaryFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueButtonColor,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 340,
                child: Text(
                  'To reset your password, you need your email or mobile number that can be authenticated.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    fontSize: 15,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/forgotpassword1.png',
                width: 160,
                height: 110,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 55),
              SizedBox(
                width: 317,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFont,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        decoration: AppInputStyles.inputDecoration(
                          hintText: 'johndoe@example.com',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 317,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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
                          builder: (context) => const VerifyCodePage()),
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
              const SizedBox(height: 25),
              SizedBox(
                width: 317,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: AppColors.secondaryButtonColor,
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
                          builder: (context) => const LoginJobSeeker()),
                    );
                  },
                  child: const Text(
                    'BACK TO LOGIN',
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
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
