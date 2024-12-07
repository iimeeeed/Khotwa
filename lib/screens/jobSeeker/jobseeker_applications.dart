import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import '../../widgets/bottom_bar.dart';
import '../../data/jobs_data.dart';
import 'application_details.dart';

class JobseekerApplications extends StatefulWidget {
  const JobseekerApplications({super.key});

  @override
  State<JobseekerApplications> createState() => _JobseekerApplicationsState();
}

class _JobseekerApplicationsState extends State<JobseekerApplications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(isJobseeker: true),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: AppSizes.getScreenHeight(context) * 0.07,
          ),
          SizedBox(
            width: AppSizes.getScreenWidth(context) * 0.9,
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
                      color: AppColors.blueButtonColor,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.getScreenWidth(context) * 0.2),
                const Text(
                  'My Applications',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.blueButtonColor,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: applicationCards.length,
              itemBuilder: (context, index) {
                final job = applicationCards[index];

                return Container(
                  width: AppSizes.getScreenWidth(context) * 0.9,
                  height: AppSizes.getScreenHeight(context) * 0.3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 1),
                                radius: 22,
                                backgroundImage: AssetImage(job['logoUrl']!),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                job['companyName'] ?? 'Company Name',
                                style: const TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            job['applicationDetails'] ?? '',
                            style: const TextStyle(
                                color: AppColors.blackTextColor,
                                fontFamily: 'poppins'),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            job['companyReviewText'] ?? '',
                            style: const TextStyle(
                                color: AppColors.blackTextColor,
                                fontFamily: 'poppins'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ApplicationDetailsScreen(
                                    applicationCard: job,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: AppSizes.getScreenWidth(context) * 0.5,
                              height: AppSizes.getScreenHeight(context) * 0.05,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF84BDA9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Application Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'poppin',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            job['time'] ?? '',
                            style: const TextStyle(
                              color: AppColors.blueButtonColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
