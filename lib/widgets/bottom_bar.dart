import 'package:flutter/material.dart';
import 'package:khotwa/screens/company/company_dashboard.dart';
import 'package:khotwa/screens/company/company_home.dart';
import 'package:khotwa/screens/jobSeeker/jobseeker_applications.dart';
import 'package:khotwa/screens/jobSeeker/saved_jobs.dart';
import '../commons/constants.dart';
import 'bottom_sheet.dart';
import '../screens/company/settings/main_settings.dart';
import 'notifications_screen.dart';
import '../screens/company/create_post_screen.dart';
import '../commons/profile.dart';
import '../screens/jobSeeker/homePage.dart';

class BottomBar extends StatefulWidget {
  final bool
      isJobseeker; // if true we get the bottom bar of the jbseeker , else company
  final int id;
  const BottomBar({super.key, required this.isJobseeker, required this.id});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home tab
          _buildTab(
            icon: Icons.home_outlined,
            label: 'Home',
            index: 0,
          ),
           if (widget.isJobseeker == false)
                       _buildTab(
              icon: Icons.dashboard_customize,
              label: 'Dashboard',
              index: 1,
            ),
          // Search tab
          if (widget.isJobseeker == true)
            _buildTab(
              icon: Icons.work_outline_outlined,
              label: 'Apps',
              index: 1,
            ),
                     

          
          widget.isJobseeker
              ? _buildTab(
                  icon: Icons.bookmark_outline,
                  label: 'Saved',
                  index: 2,
                )
              : _buildTab(
                  icon: Icons.add_box_outlined,
                  label: 'Create',
                  index: 2,
                ),
          // Notifications tab
          _buildTab(
            icon: Icons.notifications_outlined,
            label: 'Notifs',
            index: 3,
          ),
          // Profile tab
          _buildTab(
            icon: Icons.person_outlined,
            label: 'Profile',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          bool isComp = (widget.isJobseeker) ? false : true;
          selectedIndex = index;

          switch (label) {
            case "Home":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (widget.isJobseeker)
                      ? JobseekerHome(id: widget.id,)
                      : CompanyHome(id: widget.id,),
                ),
              );
              break;
            case "Notifs":
              BottomDialog.show(
                context,
                NotificationsScreen(
                  isCompany: isComp,
                ),
              );
              break;
              case "Apps":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JobseekerApplications(),
                ),
              );
              break;
            case "Saved":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedJobs(),
                ),
              );
              break;

            case "Create":
              BottomDialog.show(context, CreatePost(id : widget.id));
              break;
            case "Profile":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Profile(isCompany: (widget.isJobseeker) ? false : true, id: widget.id,),
                ),
              );
              break;
            case "Dashboard":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const CompanyDashboard()
                      
                ),
              );
              break;

            default:
              BottomDialog.show(
                  context,
                  SettingsPage(
                    isCompany: (widget.isJobseeker) ? false : true,
                    id: widget.id,
                  ));
              break;
          }
        });
      },
      child: Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(
                color:
                    isSelected ? AppColors.lightGreenColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected
                      ? AppColors.lightGreenColor
                      : AppColors.greyTextColor),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.lightGreenColor
                      : AppColors.greyTextColor,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
