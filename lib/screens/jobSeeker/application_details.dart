import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobSeeker/homePage.dart';
import '../../commons/constants.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> applicationCard;

  const ApplicationDetailsScreen({super.key, required this.applicationCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: AppSizes.getScreenHeight(context) * 0.07),
            _buildHeader(context),
            SizedBox(height: AppSizes.getScreenHeight(context) * 0.05),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJobDetails(context),
                  SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
                  _buildApplicationDetails(context),
                  SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
                ],
              ),
            ),
            SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.blueButtonColor,
            size: 24,
          ),
        ),
        const Spacer(),
        const Text(
          'Application Details',
          style: TextStyle(
            color: AppColors.blueButtonColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Spacer(),
      ],
    );
  }

  // Job Details Section
  Widget _buildJobDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(applicationCard['logoUrl'] ?? ''),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  applicationCard['jobTitle'] ?? 'Job Title Not Available',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueButtonColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${applicationCard['companyName']}, ${applicationCard['jobLocation']}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
        Text(
          "- Shipped on ${applicationCard['shippedOn'] ?? 'N/A'}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Text(
          "- Updated by recruiter 8 hours ago.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
        _buildSectionTitle('Job Details'),
        Text(
          "- ${applicationCard['jobType'] ?? 'N/A'}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          "- ${applicationCard['jobExperience'] ?? 'N/A'}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Application Details Section
  Widget _buildApplicationDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Application Details'),
        const Text(
          "- CV/Resume",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Image(image: AssetImage("assets/PDF.png")),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '14 Feb 2022 at 11:30 am',
                      style: TextStyle(
                        color: Color(0xFFB5B6B7),
                        fontSize: 10,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    Text(
                      'Jamet kudasi - CV - UI/UX Designer.PDF',
                      style: TextStyle(
                        color: Color(0xFF1A3F70),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Action Button
  Widget _buildActionButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JobseekerHome()),
          );
        },
        child: Container(
          width: AppSizes.getScreenWidth(context) * 0.6,
          height: AppSizes.getScreenHeight(context) * 0.08,
          decoration: ShapeDecoration(
            color: AppColors.lightGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Center(
            child: Text(
              'Apply For More Jobs',
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
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.blueButtonColor,
      ),
    );
  }
}
