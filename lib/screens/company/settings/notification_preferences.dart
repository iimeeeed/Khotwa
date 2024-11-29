import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({super.key});

  @override
  State<NotificationPreferences> createState() =>
      _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  final List<Map<String, dynamic>> jobAlertsTiles = [
    {'title': 'New Job Alerts', 'isActive': true},
    {'title': 'Job Application Updates', 'isActive': false},
    {'title': 'Job Recommendations', 'isActive': true},
  ];

  final List<Map<String, dynamic>> interviewNotificationsTiles = [
    {'title': 'Interview Invitations', 'isActive': true},
    {'title': 'Interview Feedbacks', 'isActive': false},
  ];

  final List<Map<String, dynamic>> generalNotificationsTiles = [
    {'title': 'Features Updates', 'isActive': true},
    {'title': 'Reminder Notifications', 'isActive': false},
    {'title': 'Profile Completion Tips', 'isActive': true},
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 58),
                  const Text(
                    'Notification Preferences',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
                      const SizedBox(height: 16),
                      buildNotificationCard(
                        "Job Alerts",
                        description:
                            "These are notifications that newly-posted jobs match with your profile.",
                        tiles: jobAlertsTiles,
                      ),
                      const SizedBox(height: 25),
                      buildNotificationCard(
                        "Interview Notifications",
                        description:
                            "These are notifications to help you manage your interview process efficiently.",
                        tiles: interviewNotificationsTiles,
                      ),
                      const SizedBox(height: 25),
                      buildNotificationCard(
                        "General Notifications",
                        description:
                            "These are notifications to keep you informed with helpful tips, updates on new features.",
                        tiles: generalNotificationsTiles,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 266,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF84BDA9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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

  Widget buildNotificationCard(
    String title, {
    required String description,
    required List<Map<String, dynamic>> tiles,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.blueButtonColor,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Column(
                children: tiles.map((tile) {
                  return buildNotificationTile(
                    title: tile['title'],
                    isActive: tile['isActive'],
                    onToggle: (bool value) {
                      setState(() {
                        tile['isActive'] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNotificationTile({
    required String title,
    required bool isActive,
    required void Function(bool) onToggle,
  }) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 16, right: 6),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: Transform.scale(
        scale: 0.6,
        child: Switch(
          value: isActive,
          onChanged: onToggle,
          activeTrackColor: AppColors.lightGreenColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: AppColors.blueButtonColor,
        ),
      ),
    );
  }
}
