import 'package:flutter/material.dart';
import 'flowSignUp/flow.dart' as flow_screen;
import 'forgotPassword/forgot_password_page.dart';

class JobSeekerForm extends StatefulWidget {
  const JobSeekerForm({super.key});

  @override
  State<JobSeekerForm> createState() => _JobSeekerFormState();
}

class _JobSeekerFormState extends State<JobSeekerForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full name",
              style: TextStyle(
                  fontFamily: "DM Sans",
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
                controller: _fullnameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Full name",
                    hintStyle: const TextStyle(
                        fontFamily: "DM Sans",
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
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                  fontFamily: "DM Sans",
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
                        fontFamily: "DM Sans",
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
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(
                  fontFamily: "DM Sans",
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
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            fontFamily: "DM Sans",
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
                  Transform.translate(
                    child: Image.asset("assets/eye.png"),
                    offset: const Offset(270, 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Checkbox(
              activeColor: const Color(0xFFFFEFCB),
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
              width: 50,
            ),
                           GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordFlowScreen(),
      ),
    );
  },
  child: Text(
    'Forgot password?',
    style: TextStyle(
      color: Color(0xFF0D0140), // Define your custom color
      decoration: TextDecoration.underline, // Underline the text
    ),
  ),
)


          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 266,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const flow_screen.Flow()),
            );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B4174),
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
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
                "SIGN UP WITH GOOGLE",
                style: TextStyle(
                    fontFamily: "DM Sans",
                    color: Color(0xFF1B4174),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                  fontFamily: "DM Sans italic",
                  color: Color(0xFF524B6B),
                  fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Sign in",
              style: TextStyle(
                fontFamily: "DM Sans italic",
                color: Color(0xFFFF9228),
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFF9228),
              ),
            ),
          ],
        )
      ],
    );
  }
}
