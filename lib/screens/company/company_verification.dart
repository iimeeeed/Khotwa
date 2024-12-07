import 'package:flutter/material.dart';
import 'package:khotwa/screens/company/company_home.dart';
import '../../commons/constants.dart';

class CompanyVerificationPage extends StatefulWidget {
  const CompanyVerificationPage({super.key});

  @override
  _CompanyVerificationPageState createState() =>
      _CompanyVerificationPageState();
}

class _CompanyVerificationPageState extends State<CompanyVerificationPage> {
  int currentStep = 0;
  bool isSelected = false;

  final PageController _pageController = PageController();

  Widget getProgressIndicator(String step) {
    return Positioned(
      left: 0,
      top: -20,
      child: Text(
        step,
        style: const TextStyle(
          color: AppColors.lightGreenColor,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget getProgressIcon(bool isLast) {
    return Positioned(
      left: isLast ? 60 : 15,
      top: -26,
      child: Image.asset(
        "assets/man.png",
        height: 40,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 0),
              (currentStep == 0)
                  ? getProgressIndicator('Basic Information')
                  : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 1),
              (currentStep == 1)
                  ? getProgressIndicator('Contact Details')
                  : (currentStep == 0)
                      ? getProgressIcon(false)
                      : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 2),
              (currentStep == 2)
                  ? getProgressIndicator('Company Profile')
                  : (currentStep == 1)
                      ? getProgressIcon(false)
                      : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 3),
              if (currentStep == 3) ...[
                getProgressIndicator('Identification'),
                getProgressIcon(true),
              ] else if (currentStep == 2) ...[
                getProgressIcon(false),
              ] else
                Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildProgressSegment({bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 7,
        decoration: ShapeDecoration(
          color: isActive ? AppColors.lightGreenColor : const Color(0xFFEFF3F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint,
      {double height = 55.0, double width = 120}) {
    width = label == "Company Description" ? 200 : 120;
    height = label == "Company Description" ? 150 : 90;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFB0B0B0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment:
                  (label == "Logo") ? Alignment.center : Alignment.centerLeft,
              child: label == "Logo"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.cloud_upload,
                            color: Color.fromARGB(255, 216, 219, 218),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Drop here to attach or ',
                                style: TextStyle(
                                  color: Color(0xFFD5D9D8),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              TextSpan(
                                text: 'upload',
                                style: TextStyle(
                                  color: Color(0xFF93C5FD),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                  letterSpacing: -0.32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Max size: 5MB',
                          style: TextStyle(
                            color: Color(0xFFD5D9D8),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.14,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ],
                    )
                  : TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: const TextStyle(
                          color: Color(0xFFD5D9D8),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                        prefixText: label == "Website" ? "https://" : null,
                        prefixStyle: const TextStyle(
                          color: AppColors.blueButtonColor,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.26,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: AppColors.blueButtonColor,
                    ),
            ),
            Positioned(
              top: -12,
              left: 16,
              child: Container(
                width: width,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEFF3F2),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFCDD0CF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.blueButtonColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Khotwa",
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
                      fontFamily: "Khmer MN",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Company Verification',
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
                      fontSize: 20,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildProgressIndicator(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: AppSizes.getScreenHeight(context),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF3F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSizes.getScreenHeight(context) * 0.65,
                      child: Column(
                        children: [
                          if (currentStep == 0) ...[
                            const Center(
                              child: Text(
                                'Fill your Company Details',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            _buildInputField(
                                'Company Name', 'Your Company Name'),
                            const SizedBox(height: 30),
                            _buildInputField(
                                'Industry', 'Select your Industry'),
                            const SizedBox(height: 30),
                            _buildInputField(
                                'Company Size', 'Select your Company Size'),
                            const SizedBox(height: 20),
                          ] else if (currentStep == 1) ...[
                            const Center(
                              child: Text(
                                'Enter your contact infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            _buildInputField('Email Address', 'Email'),
                            const SizedBox(height: 30),
                            _buildInputField('Phone Number', 'Phone Number'),
                            const SizedBox(height: 30),
                            _buildInputField('Location', 'Your Exact Address'),
                            const SizedBox(height: 20),
                          ] else if (currentStep == 2) ...[
                            const Center(
                              child: Text(
                                'Enter your Profile infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            _buildInputField(
                                'Website', "Your company's website link"),
                            const SizedBox(height: 30),
                            _buildInputField(
                                'Logo', 'Drop here to attach or upload',
                                height: 130),
                            const SizedBox(height: 30),
                            _buildInputField('Company Description',
                                "Briefly describe your company's mission, vision, and services",
                                height: 130),
                            const SizedBox(height: 30),
                          ] else if (currentStep == 3) ...[
                            const Center(
                              child: Text(
                                'Enter your Identification infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            _buildInputField('Trade Register Number (RC)',
                                "`Registre de Commerce` number"),
                            const SizedBox(height: 30),
                            _buildInputField('Tax Identification Number (NIF)',
                                "`Numéro d'Identification Fiscale`"),
                            const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSelected = !isSelected;
                                    });
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: ShapeDecoration(
                                      color: isSelected
                                          ? AppColors.lightGreenColor
                                          : Colors.white,
                                      shape: const OvalBorder(
                                        side: BorderSide(
                                          width: 0.5,
                                          color: AppColors.blueButtonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                'I confirm I represent HR/Personnel, Recruiting, Marketing, PR, or am an executive at my company and I agree to Khotwa\'s '),
                                        TextSpan(
                                          text: 'Terms of Use',
                                          style: TextStyle(
                                              color: Color(0xFF6EA5ED)),
                                        ),
                                        TextSpan(text: ' and acknowledge its '),
                                        TextSpan(
                                          text: 'privacy policy',
                                          style: TextStyle(
                                              color: Color(0xFF6EA5ED)),
                                        ),
                                        TextSpan(
                                            text: ' on behalf of my company.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (currentStep > 0) {
                              setState(() {
                                currentStep--;
                              });
                              _pageController.animateToPage(currentStep,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEFF3F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(83, 30),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Color(0xFF95969D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (currentStep < 3) {
                              setState(() {
                                currentStep++;
                              });
                              _pageController.animateToPage(currentStep,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CompanyHome()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (currentStep == 3)
                                ? AppColors.blueButtonColor
                                : AppColors.lightGreenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(83, 30),
                          ),
                          child: Text(
                            (currentStep == 3) ? "Let's Go" : 'Next',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
