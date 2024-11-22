import 'package:flutter/material.dart';

class LoginJobSeeker extends StatefulWidget {
  const LoginJobSeeker({super.key});

  @override
  State<LoginJobSeeker> createState() => _LoginJobSeekerState();
}

class _LoginJobSeekerState extends State<LoginJobSeeker> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFF3F2),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
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
                fontFamily: "Khmer MN",
                fontSize: 40,
                color: Color(0xFF1B4174),
                fontWeight: FontWeight.w500),
          ),
          const Text(
            "We’re glad to see you again ! Log in to.",
            style: TextStyle(fontFamily: "DM Sans"),
          ),
          const Text(
            " your account",
            style: TextStyle(fontFamily: "DM Sans"),
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
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "johndoe@example.com",
                      hintStyle: const TextStyle(
                          fontFamily: "DM Sans",
                          color: Colors.grey,
                          fontSize: 15),
                      border: OutlineInputBorder(
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
                          border: OutlineInputBorder(
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
              const SizedBox(
                height: 10,
              ),
            ],
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
                width: 90,
              ),
              GestureDetector(
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                      fontFamily: "DM Sans",
                      color: Color(0xFF0D0140),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {},
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
              onPressed: () {},
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B4174),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
                  style:
                      TextStyle(fontFamily: "DM Sans", color: Color(0xFF1B4174),fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You don't have an account yet?",style: TextStyle(
                fontFamily: "DM Sans italic",
                color: Color(0xFF524B6B),
                fontSize: 12
              ),),
              SizedBox(width: 5,),
              Text("Sign up",style: TextStyle(
                fontFamily: "DM Sans italic",
                color: Color(0xFFFF9228),
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFF9228),
              ),),
            ],
          )
        ]),
      ),
    );
  }
}
