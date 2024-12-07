import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 140,
              decoration: const BoxDecoration(color: AppColors.blueButtonColor),
            ),
          ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 90),
                  const Text(
                    'Security Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const ShapeDecoration(
                  color: Color(0xFFEFF3F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        height: AppSizes.getScreenHeight(context) * 0.2,
                        child: const Image(
                            image: AssetImage("assets/Security.png")),
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.05),
                      const Text(
                        'Change Password',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.blueButtonColor,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.05),
                      _buildCurrentPasswordField(),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.05),
                      _buildNewPasswordField(),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.05),
                      _buildConfirmPasswordField(),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.08),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: AppSizes.getScreenWidth(context) * 0.6,
                            height: AppSizes.getScreenHeight(context) * 0.08,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF84BDA9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Center(
                              child: Text(
                                'Save Changes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'poppin',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: MediaQuery.of(context).size.width / 2 - 17.5,
            child: Container(
              height: 4,
              width: 35,
              decoration: ShapeDecoration(
                color: AppColors.greyTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Old Password",
          style: TextStyle(
              fontFamily: AppFonts.secondaryFont,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 317,
          height: 50,
          child: Stack(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: !_currentPasswordVisible,
                textAlign: TextAlign.left,
                decoration:
                    AppInputStyles.inputDecoration(hintText: "Old Password"),
              ),
              Positioned(
                right: 10,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPasswordVisible = !_currentPasswordVisible;
                    });
                  },
                  child: Icon(
                    _currentPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "New Password",
          style: TextStyle(
              fontFamily: AppFonts.secondaryFont,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 317,
          height: 50,
          child: Stack(
            children: [
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_newPasswordVisible,
                textAlign: TextAlign.left,
                decoration:
                    AppInputStyles.inputDecoration(hintText: "New Password"),
              ),
              Positioned(
                right: 10,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _newPasswordVisible = !_newPasswordVisible;
                    });
                  },
                  child: Icon(
                    _newPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirm Password",
          style: TextStyle(
              fontFamily: AppFonts.secondaryFont,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 317,
          height: 50,
          child: Stack(
            children: [
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                textAlign: TextAlign.left,
                decoration: AppInputStyles.inputDecoration(
                    hintText: "Confirm Password"),
              ),
              Positioned(
                right: 10,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                  child: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
