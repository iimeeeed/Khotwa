import 'package:flutter/material.dart';
import '../../../commons/constants.dart';
import 'change_password.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        children: [
          // Blue background header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 110,
              decoration: const BoxDecoration(color: AppColors.blueButtonColor),
            ),
          ),
          // Gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.03, -1.00),
                  end: const Alignment(-0.03, 1),
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Back button and title
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 60),
                const Text(
                  'Security Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: AppFonts.secondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildEmailSection(),
                    _buildPasswordSection(),
                    _buildTwoFactorSection(),
                    _buildPhoneSection(),
                    _buildLastSignInSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSection() {
    return _buildSecuritySection(
      'Email',
      'bhjohbhjolnlknjm;',
      Icons.email_outlined,
      onTap: () {},
    );
  }

  Widget _buildPasswordSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.lock_outline, color: AppColors.greyTextColor),
              SizedBox(width: 15),
              Text(
                'Password',
                style: TextStyle(
                  color: AppColors.blackTextColor,
                  fontSize: 14,
                  fontFamily: AppFonts.secondaryFont,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePassword(),
                ),
              );
            },
            child: const Text(
              'Change Password',
              style: TextStyle(
                color: AppColors.lightGreenColor,
                fontSize: 14,
                fontFamily: AppFonts.secondaryFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoFactorSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.greyTextColor),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              '2-FA autentification',
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontSize: 14,
                fontFamily: AppFonts.secondaryFont,
              ),
            ),
          ),
          Switch(
            value: _twoFactorEnabled,
            onChanged: (value) {
              setState(() {
                _twoFactorEnabled = value;
              });
            },
            activeTrackColor: AppColors.lightGreenColor,
            inactiveTrackColor: AppColors.blueButtonColor,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneSection() {
    return _buildSecuritySection(
      'Phone number',
      '0540156390',
      Icons.phone_outlined,
      onTap: () {},
    );
  }

  Widget _buildLastSignInSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.people_outline, color: AppColors.greyTextColor),
              SizedBox(width: 15),
              Text(
                'Last sign in',
                style: TextStyle(
                  color: AppColors.blackTextColor,
                  fontSize: 14,
                  fontFamily: AppFonts.secondaryFont,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'today at 18:34, Safary 198.123.23.23',
                  style: TextStyle(
                    color: AppColors.greyTextColor,
                    fontSize: 12,
                    fontFamily: AppFonts.secondaryFont,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Total active sessions',
                  style: TextStyle(
                    color: AppColors.blackTextColor,
                    fontSize: 14,
                    fontFamily: AppFonts.secondaryFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'DESKTOP-6TIG6EC • Kyiv, Ukraine\niphone 11 • Kyiv, Ukraine',
                  style: TextStyle(
                    color: AppColors.greyTextColor,
                    fontSize: 12,
                    fontFamily: AppFonts.secondaryFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection(
    String title,
    String value,
    IconData icon, {
    bool showChangeButton = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.greyTextColor),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.blackTextColor,
                    fontSize: 14,
                    fontFamily: AppFonts.secondaryFont,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.greyTextColor,
                    fontSize: 12,
                    fontFamily: AppFonts.secondaryFont,
                  ),
                ),
              ],
            ),
          ),
          if (showChangeButton)
            TextButton(
              onPressed: onTap,
              child: const Text(
                'Change Password',
                style: TextStyle(
                  color: Color(0xFF84BDA9),
                  fontSize: 12,
                  fontFamily: AppFonts.secondaryFont,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
