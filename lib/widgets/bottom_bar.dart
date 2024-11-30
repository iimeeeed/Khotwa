import 'package:flutter/material.dart';
import '../commons/constants.dart';

class BottomBar extends StatefulWidget {
  final bool
      isJobseeker; // if true we get the bottom bar of the jbseeker , else company
  const BottomBar({super.key, required this.isJobseeker});

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
          // Search tab
          _buildTab(
            icon: Icons.search,
            label: 'Search',
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
                  label: 'Jobs',
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
          selectedIndex = index;
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
