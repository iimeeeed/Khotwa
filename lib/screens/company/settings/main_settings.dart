import 'package:flutter/material.dart';
import 'package:khotwa/commons/profile.dart';
import 'package:khotwa/screens/Signup.dart';
import 'package:khotwa/screens/jobSeeker/saved_jobs.dart';
import '../../../commons/constants.dart';
import 'notification_preferences.dart';
import 'security_settings.dart';
import 'report_problem.dart';
import 'terms_policies.dart';
import 'About.dart';
import 'help_support.dart';

class SettingsPage extends StatefulWidget {
  final int id;
  final bool isCompany;

  const SettingsPage({super.key, required this.isCompany, required this.id});

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
          _buildHeaderBackground(),
          _buildHeaderContent(context),
          _buildSettingsContent(context),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 140,
        decoration: const BoxDecoration(color: AppColors.blueButtonColor),
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    return Positioned(
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
              onTap: () => Navigator.pop(context),
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
            SizedBox(
              width: AppSizes.getScreenWidth(context) * 0.32,
            ),
            const Text(
              'Settings',
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
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    return Positioned(
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
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildSettingsCard(
                  'Account',
                  items: [
                    _buildSettingsItem(Icons.person_outline, 'Edit profile'),
                    _buildSettingsItem(Icons.security_outlined, 'Security'),
                    _buildSettingsItem(
                        Icons.notifications_active_outlined,
                        'Notifications Preferences'),
                   
                    if (!widget.isCompany)
                      _buildSettingsItem(Icons.archive_outlined, 'Saved Jobs'),
                  ],
                ),
                const SizedBox(height: 26),
                _buildSettingsCard(
                  'Support & About',
                  items: [
                    _buildSettingsItem(Icons.help_outline, "Help & Support"),
                    _buildSettingsItem(
                        Icons.policy_outlined, "Terms and Policies"),
                    _buildSettingsItem(Icons.info_outline, "About"),
                  ],
                ),
                const SizedBox(height: 26),
                _buildSettingsCard(
                  "Actions",
                  items: [
                    _buildSettingsItem(Icons.flag_outlined, "Report a Problem"),
                    
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
    );
  }

  Widget _buildSettingsCard(String title, {required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.blueButtonColor,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: items),
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
      onTap: () => _onSettingItemTap(text),
    );
  }

  void _onSettingItemTap(String text) {
    switch (text) {
      case 'Edit profile':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(isCompany: widget.isCompany, id: widget.id),
          ),
        );
        break;
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
      case 'Log Out':
        _handleLogout();
        break;
      case 'Saved Jobs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SavedJobs()),
        );
        break;
      default:
        break;
    }
  }

  void _handleLogout() async {
    // Example: Perform logout actions like FirebaseAuth sign out
    // await FirebaseAuth.instance.signOut();

    // Navigate to the Signup screen, removing all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Signup()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }
}
