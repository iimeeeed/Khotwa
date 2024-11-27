import 'package:flutter/material.dart';
import 'package:khotwa/screens/Signup.dart';
import 'package:khotwa/screens/jobSeeker/forgotPassword/forgot_password_page.dart';
import 'homePage.dart';
import '../../commons/constants.dart';

class LoginJobSeeker extends StatefulWidget {
  const LoginJobSeeker({super.key});

  @override
  State<LoginJobSeeker> createState() => _LoginJobSeekerState();
}

class _LoginJobSeekerState extends State<LoginJobSeeker> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset("assets/Khotwa.png"),
              ),
            ],
          ),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 50,
        ),
        Center(child: Image.asset("assets/asset1.png")),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Welcome back",
          style: TextStyle(
              fontFamily: AppFonts.primaryFont,
              fontSize: 40,
              color: AppColors.blueButtonColor,
              fontWeight: FontWeight.w500),
        ),
        const Text(
          "We’re glad to see you again ! Log in to.",
          style: TextStyle(fontFamily: AppFonts.secondaryFont),
        ),
        const Text(
          " your account",
          style: TextStyle(fontFamily: AppFonts.secondaryFont),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 317,
              height: 50,
              child: TextFormField(
                controller: _emailController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "johndoe@example.com",
                    hintStyle: const TextStyle(
                        fontFamily: AppFonts.secondaryFont,
                        color: Colors.grey,
                        fontSize: 15),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Password",
              style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
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
                            fontSize: 15),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        )),
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: AppSizes.getScreenWidth(context) * 0.12),
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
            const SizedBox(
              width: 90,
            ),
            GestureDetector(
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    color: AppColors.blueButtonColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
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
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 266,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobSearchApp(),
                ),
              );
            },
            child: const Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueButtonColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/google.png"),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "SIGN IN WITH GOOGLE",
                style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    color: AppColors.blueButtonColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You don't have an account yet?",
              style: TextStyle(
                  fontFamily: AppFonts.secondaryFontItalic,
                  color: Color(0xFF524B6B),
                  fontSize: 12),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signup(),
                  ),
                );
              },
              child: Text(
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
        )
      ]),
    );
  }
}
