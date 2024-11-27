import 'package:flutter/material.dart';
import '../../../commons/constants.dart';
import '../../../commons/khotwa_logo.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        leading: null, 
         automaticallyImplyLeading: false,
        actions: [
          KhotwaLogo(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.08),
              const Text(
                'Successfully',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4174),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your password has been updated, please change your password regularly to avoid this happening.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/forgotpassword3.png',
                width: 160,
                height: 110,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppSizes.getScreenHeight(context)*0.08),
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
                   
                  },
                  child: const Text(
                    'CONTINUE',
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
