import 'package:flutter/material.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'reset_password_page.dart';
import '../../../commons/constants.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        actions: const [KhotwaLogo()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Verify Code',
                style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueButtonColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your verification code from your email or phone number that we’ve sent.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 16,
                  color: AppColors.greyTextColor,
                ),
              ),
              SizedBox(height: ((MediaQuery.of(context).size.height) / 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => const SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.blueButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ((MediaQuery.of(context).size.height) / 6)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 17,
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
                          builder: (context) => const ResetPasswordPage()),
                    );
                  },
                  child: const Text(
                    'VERIFY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn’t receive a code?",
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
                      fontFamily: AppFonts.secondaryFont,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, 0),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                          color: AppColors.secondaryLinkColor,
                          fontFamily: AppFonts.secondaryFont,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
