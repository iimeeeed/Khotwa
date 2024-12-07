import 'package:flutter/material.dart';
import '../data/notifications_data.dart';
import '../commons/constants.dart';

class NotificationsScreen extends StatelessWidget {
  final bool isCompany;
  const NotificationsScreen({super.key, required this.isCompany});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications =
        (isCompany) ? companyNotifications : jobseekerNotifications;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationTile(
                    context,
                    title: notifications[index]['title'] ?? '',
                    description: notifications[index]['description'] ?? '',
                    time: notifications[index]['time'] ?? '',
                    color:
                        (index == 0) ? AppColors.lightGreenColor : Colors.white,
                    textColor:
                        (index > 0) ? AppColors.blackTextColor : Colors.white,
                  );
                },
              )),
          
        ],
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context, {
    required String title,
    required String description,
    required String time,
    required Color color,
    required Color textColor,
  }) {
    final double width = MediaQuery.of(context).size.width * 0.9;
    final double height = MediaQuery.of(context).size.height * 0.2;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (title.isNotEmpty)
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: textColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 14,
                fontFamily: "poppins",
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 12,
                      fontFamily: "poppins",
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Icon(Icons.timelapse_outlined, size: 14, color: textColor.withOpacity(0.6),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
