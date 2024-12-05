import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class TermsPolicies extends StatefulWidget {
  const TermsPolicies({super.key});

  @override
  State<TermsPolicies> createState() => _TermsPoliciesState();
}

class _TermsPoliciesState extends State<TermsPolicies> {
  // Define the sections data dynamically
  List<Map<String, dynamic>> sections = [
    {
      'title': 'Terms of Service',
      'content': [
        {
          'title': 'Eligibility:',
          'content': 'Users must be at least 18 years old to create an account.'
        },
        {
          'title': 'Account Responsibilities:',
          'content':
              'Users are responsible for keeping login details private and secure.'
        },
        {
          'title': 'Acceptable Use:',
          'content':
              'Users agree not to post false information, harass others....'
        },
      ]
    },
    {
      'title': 'Privacy Policy',
      'content': [
        {
          'title': 'Data Collection:',
          'content':
              'We collect personal info, job preferences, and app usage data.'
        },
        {
          'title': 'Data Sharing:',
          'content':
              'Data may be shared with employers for applications or with third-party services (e.g., for analytics).'
        },
        {
          'title': 'Data Security:',
          'content':
              'We apply security measures to protect user data from unauthorized access.'
        },
      ]
    },
    {
      'title': 'Disclaimers',
      'content': [
        {
          'title': 'No Job Guarantee:',
          'content': 'We do not guarantee job placements or outcomes.'
        },
        {
          'title': 'Accuracy:',
          'content':
              'While we strive for accuracy, we are not responsible for misinformation by users or employers.'
        },
      ]
    },
  ];

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
              child: SizedBox(
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
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 80),
                    const Text(
                      'Terms & Policies',
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
                    children: sections.map((section) {
                      return Column(
                        children: [
                          buildCard(
                              section['title'], section['content']),
                          const SizedBox(height: 26),
                        ],
                      );
                    }).toList(),
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

  Widget buildCard(
      String title, List<Map<String, String>> sectionContent) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.blueButtonColor,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0.08,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...sectionContent.map((section) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: section['title'],
                            style: const TextStyle(
                              color: AppColors.blueButtonColor,
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: section['content'],
                            style: const TextStyle(
                              color: AppColors.greyTextColor,
                              fontSize: 12,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
