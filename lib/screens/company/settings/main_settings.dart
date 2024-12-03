import 'package:flutter/material.dart';
import '../../../commons/constants.dart';
import 'notification_preferences.dart';
import 'security_settings.dart';
import 'report_problem.dart';
import 'terms_policies.dart';
import 'About.dart';
import 'help_support.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 110),
                    const Text(
                      'Settings',
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
                        height: 16,
                      ),
                      _buildSettingsCard('Account', items: [
                        _buildSettingsItem(
                            Icons.person_outline, 'Edit profile'),
                        _buildSettingsItem(Icons.security_outlined, 'Security'),
                        _buildSettingsItem(Icons.notifications_active_outlined,
                            'Notifications Preferences'),
                        _buildSettingsItem(
                            Icons.privacy_tip_outlined, 'Privacy'),
                        _buildSettingsItem(
                            Icons.archive_outlined, 'Saved Jobs'),
                      ]),
                      const SizedBox(height: 26),
                      _buildSettingsCard(
                        'Support & About',
                        items: [
                          _buildSettingsItem(
                              Icons.help_outline, "Help & Support"),
                          _buildSettingsItem(
                              Icons.policy_outlined, "Terms and Policies"),
                          _buildSettingsItem(Icons.info_outline, "About"),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _buildSettingsCard(
                        "Actions",
                        items: [
                          _buildSettingsItem(
                              Icons.flag_outlined, "Report a Problem"),
                          _buildSettingsItem(
                              Icons.person_add_alt_1_outlined, "Add Account"),
                          _buildSettingsItem(
                            Icons.logout,
                            "Log Out",
                            iconColor: AppColors.secondaryLinkColor,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryLinkColor,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildSettingsCard(String title, {required List<Widget> items}) {
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
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String text, {
    Color iconColor = AppColors.blueButtonColor,
    TextStyle? textStyle,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: textStyle ??
            const TextStyle(fontSize: 16, color: AppColors.blackTextColor),
      ),
      onTap: () {
        switch (text) {
          case 'Security':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecuritySettings()),
            );
            break;
          case 'Notifications Preferences':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationPreferences()),
            );
            break;
          case 'Report a Problem':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportProblem()),
            );
            break;
          case 'Terms and Policies':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsPolicies()),
            );
            break;
          case 'About':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const About()),
            );
            break;
          case 'Help & Support':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpSupport()),
            );
            break;
          default:
            break;
        }
      },
    );
  }
}
