import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import '../../widgets/bottom_bar.dart';
import '../../data/jobs_data.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  // List to track saved jobs
  List<Map<String, dynamic>> savedJobsList = savedJobs;

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
                SizedBox(width: AppSizes.getScreenWidth(context) * 0.24),
                const Text(
                  'Saved Jobs',
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
              itemCount: savedJobsList.length, 
              itemBuilder: (context, index) {
                final job = savedJobsList[index];

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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 1),
                                    radius: 22,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/Sonatrach-Logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['title'] ?? 'Job Title',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackTextColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        job['company'] ?? 'Company Name',
                                        style: const TextStyle(
                                          color: AppColors.blackTextColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                savedJobsList.removeAt(index); 
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: const Icon(
                                Icons.bookmark_remove_outlined, 
                                color: AppColors.lightGreenColor,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.04),
                      Column(
                        children: [
                          Center(
                            child: Wrap(
                              spacing: 20,
                              children: (job['tags'] as List)
                                  .map<Widget>(
                                    (tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryBackgroundColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        tag ?? 'Tag',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.blueButtonColor,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.04),
                      Row(
                        children: [
                          Text(
                            job['salary'] ?? 'Salary',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueButtonColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            job['location'] ?? 'Location',
                            style: const TextStyle(
                              color: AppColors.blueButtonColor,
                            ),
                          ),
                        ],
                      ),
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
