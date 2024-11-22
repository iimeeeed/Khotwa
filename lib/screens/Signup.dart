import 'package:flutter/material.dart';
import 'job_seeker_form.dart';
import 'company_form.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  PageController _pageController = PageController();
  bool isJobSeeker = true;

  void switchPage(bool toJobSeeker) {
    setState(() {
      isJobSeeker = toJobSeeker;
    });
    _pageController.animateToPage(
      toJobSeeker ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F2),
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Center(child: Image.asset("assets/asset2.png")),
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontFamily: "Khmer MN",
                      fontSize: 40,
                      color: Color(0xFF1B4174),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => switchPage(true),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 1.5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isJobSeeker
                                    ? const Color(0xFF77AA98)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Job Seeker",
                            style: TextStyle(
                              fontFamily: "Khmer MN",
                              color: isJobSeeker
                                  ? const Color(0xFF77AA98)
                                  : const Color(0xFF1B4174),
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        height: 35,
                        width: 1.5,
                        decoration: BoxDecoration(
                          color: const Color(0xFF77AA98),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () => switchPage(false),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 1.5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: !isJobSeeker
                                    ? const Color(0xFF77AA98)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Company",
                            style: TextStyle(
                              
                              fontFamily: "Khmer MN",
                              color: !isJobSeeker
                                  ? const Color(0xFF77AA98)
                                  : const Color(0xFF1B4174),
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        JobSeekerForm(),
                        CompanyForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset("assets/Khotwa.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
