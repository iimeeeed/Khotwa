import 'package:flutter/material.dart';
import '../../commons/constants.dart';
import 'company/company_verification.dart';

class CompanyForm extends StatefulWidget {
  const CompanyForm({super.key});

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  bool _rememberMe = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildInputField(
          label: "Company name",
          controller: _companyNameController,
          hintText: "Company name",
        ),
        const SizedBox(height: 10),
        _buildInputField(
          label: "Email",
          controller: _emailController,
          hintText: "company@example.com",
        ),
        const SizedBox(height: 10),
        _buildPasswordField(),
        const SizedBox(height: 10),
        _buildConfirmPasswordField(),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: AppSizes.getScreenWidth(context) * 0.13),
            Checkbox(
              activeColor: AppColors.secondaryButtonColor,
              checkColor: Colors.white,
              value: _rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
            const Text(
              'Remember me',
              style: TextStyle(color: AppColors.greyTextColor, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 266,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompanyVerificationPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueButtonColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 25),
        _buildSocialSignUpButton(),
        const SizedBox(height: 20),
        _buildSignInRow(context),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontFamily: AppFonts.secondaryFont,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 317,
          height: 50,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            decoration: AppInputStyles.inputDecoration(hintText: hintText),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
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
                controller: _passwordController,
                obscureText: !_passwordVisible,
                textAlign: TextAlign.left,
                decoration:
                    AppInputStyles.inputDecoration(hintText: "Password"),
              ),
              Positioned(
                right: 10,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
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

  Widget _buildSocialSignUpButton() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/google.png"),
          const SizedBox(width: 15),
          const Text(
            "SIGN UP WITH GOOGLE",
            style: TextStyle(
                fontFamily: AppFonts.secondaryFont,
                color: AppColors.blueButtonColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
              fontFamily: AppFonts.secondaryFontItalic,
              color: AppColors.greyTextColor,
              fontSize: 12),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          child: const Text(
            "Sign in",
            style: TextStyle(
              fontFamily: AppFonts.secondaryFontItalic,
              color: AppColors.secondaryLinkColor,
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFFF9228),
            ),
          ),
        ),
      ],
    );
  }
}
