// Import necessary packages
import 'package:flutter/material.dart';
import 'package:khotwa/backend/db/auth.dart';
import 'package:khotwa/commons/forms/login_form.dart';
import 'package:khotwa/services/auth.dart';
import '../../../commons/constants.dart';
import '../../screens/company/flowSignUp.dart';
import '../../screens/jobSeeker/flowSignUp/flow.dart' as flow_screen;

class SignupForm extends StatefulWidget {
  final bool isCompany;
  const SignupForm({super.key, required this.isCompany});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _rememberMe = false;
  final bool _passwordVisible = false;
  final bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildInputField(
          label: (widget.isCompany) ? "Company Owner's name" : "Full name",
          controller: _nameController,
          hintText: (widget.isCompany) ? "Company Owner's name" : "Full name",
        ),
        const SizedBox(height: 10),
        _buildInputField(
          label: "Email",
          controller: _emailController,
          hintText: (widget.isCompany)
              ? "company@example.com"
              : "jobseeker@example.com",
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
            onPressed: _handleSignUp,
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

  Future<void> _handleSignUp() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  String confirmPassword = _confirmPasswordController.text.trim();
  String name = _nameController.text.trim();

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords do not match")),
    );
    return;
  }

  if(widget.isCompany)
  {
    Map<String, dynamic> companyData = {
      "ownerName": name,
      "email": email,
      "password": password,
    };
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FlowCompany(companyData: companyData,),
          ),
        );
  }
  else
  {
    int? successId = await _authService.signUpJobseeker(
      fullName: name,
      email: email,
      password: password,
    );

      if (successId! > 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => flow_screen.Flow(id: successId,),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to sign up. Please try again.")),
        );
      }
  }
  
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
    return _buildInputField(
      label: "Password",
      controller: _passwordController,
      hintText: "Enter your password",
    );
  }

  Widget _buildConfirmPasswordField() {
    return _buildInputField(
      label: "Confirm Password",
      controller: _confirmPasswordController,
      hintText: "Confirm your password",
    );
  }

  Widget _buildSocialSignUpButton() {
    return SizedBox(
      width: 266,
      height: 50,
      child: ElevatedButton(
        onPressed: () {}, // Add social signup logic here
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Sign Up with Google',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: AppColors.greyTextColor, fontSize: 12),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
               MaterialPageRoute(
                    builder: (context) => (widget.isCompany)
                        ? const LoginForm(
                            isCompany: true,
                          )
                        : const LoginForm(
                            isCompany: false,
                          )),
            );
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: AppColors.blueButtonColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

