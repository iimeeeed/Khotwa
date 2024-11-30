import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  bool showFAQs = true;

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
              child: Container(
                width: double.infinity,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 90),
                    const Text(
                      'Help & Support',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.08,
                      ),
                    ),
                  ],
                ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 360,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF84BDA9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            // Toggle Button
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              left: showFAQs ? 8 : 185,
                              right: !showFAQs ? 8 : 185,
                              top: 6,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFAQs = !showFAQs;
                                  });
                                },
                                child: Container(
                                  width: 160,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x26000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 44,
                              top: 14,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFAQs = true;
                                  });
                                },
                                child: Text(
                                  'FAQs',
                                  style: TextStyle(
                                    color: showFAQs
                                        ? AppColors.blueButtonColor
                                        : Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 44,
                              top: 14,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFAQs = false;
                                  });
                                },
                                child: Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    color: !showFAQs
                                        ? AppColors.blueButtonColor
                                        : Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      showFAQs ? showFAQsPart() : showContactPart(),
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

  Widget showContactPart() {
    Widget buildContactRow(IconData icon, String text) {
      return Container(
        width: 320,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.lightGreenColor),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.blackTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContactRow(Icons.email_outlined, 'KhotwaApp@example.com'),
          const SizedBox(height: 20),
          buildContactRow(
              Icons.phone_android_outlined, '0663533102-0534230222'),
          const SizedBox(height: 20),
          buildContactRow(
              Icons.location_on_outlined, 'Zeralda, Algiers, Algeria'),
          const SizedBox(height: 20),
          buildContactRow(Icons.web, 'www.ensia.com'),
        ],
      ),
    );
  }

  Widget showFAQsPart() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Type a keyword...",
                    hintStyle: const TextStyle(
                      color: Color(0xFFAFB0B6),
                      fontSize: 14,
                      fontFamily: 'popppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Color(0xFF95969D)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 44,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.filter_list, color: Color(0xFF95969D)),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const FAQWidget(
          question: 'How do I manage my notifications?',
          answer:
              'To manage notifications, go to "Settings," select "Notification Preferences," and customize your preferences.',
        ),
        const FAQWidget(
          question: 'How do I update my profile information?',
          answer: 'Go to your profile settings to update your information.',
        ),
        const FAQWidget(
          question: 'How do I apply for a job?',
          answer: 'Search for job listings in the job section and apply.',
        ),
        const FAQWidget(
          question: 'How is my personal data protected?',
          answer: 'We follow strict privacy policies to protect your data.',
        ),
        const FAQWidget(
          question: 'How do I delete my account?',
          answer: 'Visit your account settings and select "Delete Account."',
        ),
        const FAQWidget(
          question: 'Who can see my profile?',
          answer: 'Only employers and your connections can view your profile.',
        ),
      ],
    );
  }
}

class FAQWidget extends StatefulWidget {
  final String question;
  final String answer;

  const FAQWidget({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQWidgetState createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      color: AppColors.blackTextColor,
                      fontSize: 16,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ),
          if (_isOpen) ...[
            const SizedBox(height: 10),
            Text(
              widget.answer,
              style: const TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 12,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
