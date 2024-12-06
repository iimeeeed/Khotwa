import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<Map<String, dynamic>> sections = [
    {
      'title': 'About Us',
      'content': [
        {
          'title': 'Platform Overview :',
          'content':
              'Our platform is dedicated to connecting job seekers with employers across Algeria, especially supporting students and recent graduates in finding flexible job opportunities...'
        },
        {
          'title': 'Mission Statement :',
          'content':
              ' Our mission is to reduce unemployment in Algeria by providing accessible job opportunities for all. We strive to empower...'
        },
      ]
    },
    {
      'title': 'Why Choose Us',
      'content': [
        {
          'title': 'Localized Focus :',
          'content':
              'Tailored specifically for the Algerian job market, we understand the needs...'
        },
        {
          'title': 'Flexible Job Options :',
          'content':
              'From internships to part-time and full-time roles, we offer a range of opportunities to suit diverse schedules ...'
        },
        {
          'title': 'Secure and Reliable:',
          'content':
              'With a strong focus on user security and data privacy, our platform...'
        },
      ]
    },
    {
      'title': 'Our Values',
      'content': [
        {
          'title': 'Empowerment :',
          'content': 'We believe in enabling job seekers to take control of their careers, ...'
        },
        {
          'title': 'Transparency:',
          'content':
              'Committed to honesty and clarity, we ensure all job listings are reliable and up-to-date.'
        },
        {
          'title': 'Innovation:',
          'content':
              'Leveraging technology, we aim to make the job search process easier, more efficient, and more rewarding for everyone...'
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
                    const SizedBox(width: 123),
                    const Text(
                      'About',
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
                          buildCard(section['title'], section['content']),
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

  Widget buildCard(String title, List<Map<String, String>> sectionContent) {
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
