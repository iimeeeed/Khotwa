import 'package:flutter/material.dart';
import 'company/job_seeker_form.dart';
import 'company_form.dart';
import '../commons/khotwa_logo.dart';
import '../commons/constants.dart'; 

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
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                automaticallyImplyLeading: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: const [
                  KhotwaLogo(),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(child: Image.asset("assets/asset2.png")),
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontFamily: AppFonts.primaryFont,
                      fontSize: 40,
                      color: AppColors.blueButtonColor,
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
                                    ? AppColors.lightGreenColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Job Seeker",
                            style: TextStyle(
                              fontFamily: AppFonts.primaryFont,
                              color: isJobSeeker
                                  ? AppColors.lightGreenColor
                                  : AppColors.blueButtonColor,
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
                          color: AppColors.lightGreenColor,
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
                                    ? AppColors.lightGreenColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Company",
                            style: TextStyle(
                              fontFamily: AppFonts.primaryFont,
                              color: !isJobSeeker
                                  ? AppColors.lightGreenColor
                                  : AppColors.blueButtonColor,
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
                    height: MediaQuery.of(context).size.height - 160,
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
        ],
      ),
    );
  }
}
