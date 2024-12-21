import 'package:flutter/material.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'package:khotwa/commons/forms/sigup_form.dart';
import 'package:khotwa/screens/jobSeeker/forgotPassword/forgot_password_page.dart';
import '../../screens/jobSeeker/homePage.dart';
import '../../commons/constants.dart';
import '../../screens/company/company_home.dart';
import '../../services/auth.dart';

class LoginForm extends StatefulWidget {
  final bool isCompany;
  const LoginForm({super.key, required this.isCompany});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Create an AuthService instance

  bool _rememberMe = false;
  bool _obscure = true;
  bool _isLoading = false;

 void _handleLogin() async {
  setState(() {
    _isLoading = true;
  });

  final String email = _emailController.text;
  final String password = _passwordController.text;

  final user = await _authService.signIn(email, password, widget.isCompany);

  setState(() {
    _isLoading = false;
  });

  if (user != null) {
    // Navigate to the appropriate home page and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget.isCompany ? const CompanyHome() : const JobseekerHome(),
      ),
      (route) => false, // This condition ensures all previous routes are removed
    );
  } else {
    // Show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid email or password. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        actions: const [KhotwaLogo()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/asset1.png")),
            const SizedBox(height: 20),
            const Text(
              "Welcome back",
              style: TextStyle(
                fontFamily: AppFonts.primaryFont,
                fontSize: 40,
                color: AppColors.blueButtonColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "We’re glad to see you again! Log in to your account.",
              style: TextStyle(fontFamily: AppFonts.secondaryFont),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 317,
                  height: 50,
                  child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: widget.isCompany ? "company@example.com" : "jobseeker@example.com",
                      hintStyle: const TextStyle(
                        fontFamily: AppFonts.secondaryFont,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 317,
                  height: 50,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscure,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontFamily: AppFonts.secondaryFont,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 14,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          child: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.secondaryButtonColor,
                      checkColor: const Color.fromARGB(0, 255, 255, 255),
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                GestureDetector(
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontFamily: AppFonts.secondaryFont,
                      color: AppColors.blueButtonColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordFlowScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 266,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueButtonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google.png"),
                  const SizedBox(width: 15),
                  const Text(
                    "SIGN IN WITH GOOGLE",
                    style: TextStyle(
                      fontFamily: AppFonts.secondaryFont,
                      color: AppColors.blueButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You don't have an account yet?",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFontItalic,
                    color: Color(0xFF524B6B),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (widget.isCompany)
                            ? const SignupForm(isCompany: true)
                            : const SignupForm(isCompany: false),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontFamily: AppFonts.secondaryFontItalic,
                      color: AppColors.secondaryLinkColor,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.secondaryLinkColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
