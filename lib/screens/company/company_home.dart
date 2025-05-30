import 'package:flutter/material.dart';
import 'package:khotwa/backend/repository/jobs_repository.dart';
import 'package:khotwa/commons/profile.dart';
import 'package:khotwa/screens/jobSeeker/filter/filter.dart';
import '../../data/candidates_data.dart';
import '../../commons/constants.dart';
import 'candidatesDetails.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/notifications_screen.dart';
import '../../backend/repository/companies_repository.dart';
import 'dart:convert';

class CompanyHome extends StatefulWidget {
  final int id;
  //id set to 1 just for testing purposes
  const CompanyHome({super.key, required this.id});

  @override
  _CompanyHomeState createState() => _CompanyHomeState();
}


class _CompanyHomeState extends State<CompanyHome> {
  int currentIndex = 0;
  List<List<Map<String, String>>> candidatesList = candidatesData;
  late Map _company; // Store the company information
  final CompaniesRepository _companiesRepository = CompaniesRepository(); 
  final JobsRepository _jobsRepository = JobsRepository();
  @override
  void initState() {
    super.initState();
    _fetchCompanyData(); // Fetch company data when the widget is initialized
  }
    


  // Fetch the company data based on the id
  Future<void> _fetchCompanyData() async {
    final companyData = await _companiesRepository.getById(widget.id);
    if (companyData != null) {
      setState(() {
        _company = companyData; 
      });
    } else {
      setState(() {
      });
    }
  }

  Widget imageFromBase64String(String base64String) {
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.cover,
  );
}

  Widget buildCard(String title, int index,
      {Color textColor = Colors.white, Color backgroundColor = Colors.blue}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        width: 190,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(width: 0.50, color: AppColors.blueButtonColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0.10,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCandidateTile(
      String name,
      String jobTitle,
      String appliedDate,
      String interviewDate,
      String interviewPlace,
      String imageUrl,
      bool isRecommended,
      bool isPendingInterview,
      {listIndex = 0,
      int candidateIndex = 0}) {
    return Container(
      width: AppSizes.getScreenWidth(context) * 0.95,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fill,
                        ),
                        shape: const OvalBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            jobTitle,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              height: 0.10,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(
                          side: BorderSide(
                              width: 1, color: AppColors.blueButtonColor),
                        ),
                      ),
                      child: const Icon(Icons.phone,
                          size: 20, color: AppColors.blueButtonColor),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(
                          side: BorderSide(
                              width: 1, color: AppColors.blueButtonColor),
                        ),
                      ),
                      child: const Icon(Icons.email,
                          size: 20, color: AppColors.blueButtonColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          isRecommended
              ? Container()
              : Column(
                  children: [
                    const Divider(
                        color: Color(0xFFAAAFBB), height: 1, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: (isPendingInterview)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(
                                    'Interview Scheduled On : $interviewDate',
                                    style: const TextStyle(
                                      color: AppColors.blackTextColor,
                                      fontSize: 9,
                                      fontFamily: 'Poppins',
                                      letterSpacing: -0.09,
                                    ),
                                  ),
                                  Text(
                                    'Location: $interviewPlace',
                                    style: const TextStyle(
                                      color: AppColors.blackTextColor,
                                      fontSize: 9,
                                      fontFamily: 'Poppins',
                                      letterSpacing: -0.09,
                                    ),
                                  ),
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Applied: $appliedDate',
                                  style: const TextStyle(
                                    color: Color(0xFFAAAFBB),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    letterSpacing: -0.09,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.74,
                                  child: GestureDetector(
                                    onTap: () {
                                      List<int> ID = [
                                        listIndex,
                                        candidateIndex
                                      ];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CandidatesDetails(
                                            candidateId: ID,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 105,
                                      height: 35,
                                      decoration: ShapeDecoration(
                                        color: AppColors.lightGreenColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'View Application',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.07,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // Add this method to handle search
  void handleCompanySearch(String query) {
    // Implement your search logic here
    print("Searching for: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      bottomNavigationBar: BottomBar(isJobseeker: false, id : widget.id),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                "Khotwa",
                style: TextStyle(
                  color: AppColors.blueButtonColor,
                  fontFamily: "Khmer MN",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      isCompany: true, id: widget.id,
                                    )));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: _company['company_logo'] != null
                          ? MemoryImage(base64Decode(_company['company_logo']))
                          : const AssetImage('assets/icon.png') as ImageProvider,
                        radius: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "${_company['company_name']} 👋",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            (currentIndex > 0)
                ? SearchFilterBar(
                    isCompany: true,
                    onFilterTap: () {
                      BottomDialog.show(context, const Filter());
                    },
                    onSearch: handleCompanySearch,
                    filterScreen: const Filter(),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Here's what's happening today in your hiring pipeline.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.greyTextColor,
                              fontSize: 15,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCard(
                    'Active Job Postings',
                    0,
                    backgroundColor: currentIndex == 0
                        ? AppColors.blueButtonColor
                        : AppColors.primaryBackgroundColor,
                    textColor: (currentIndex == 0)
                        ? Colors.white
                        : AppColors.blueButtonColor,
                  ),
                  const SizedBox(width: 10),
                  buildCard(
                    'New Applicants',
                    1,
                    backgroundColor: currentIndex == 1
                        ? AppColors.blueButtonColor
                        : AppColors.primaryBackgroundColor,
                    textColor: currentIndex == 1
                        ? Colors.white
                        : AppColors.blueButtonColor,
                  ),
                  const SizedBox(width: 10),
                  buildCard(
                    'Pending Interviews',
                    2,
                    backgroundColor: currentIndex == 2
                        ? AppColors.blueButtonColor
                        : Colors.transparent,
                    textColor: currentIndex == 2
                        ? Colors.white
                        : AppColors.blueButtonColor,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: (currentIndex > 0) ? 10 : 30),
            (currentIndex > 0)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: candidatesList[currentIndex - 1].length,
                      itemBuilder: (context, index) {
                        final candidate =
                            candidatesList[currentIndex - 1][index];
                        bool isPendingInterview =
                            (currentIndex == 2) ? true : false;
                        return buildCandidateTile(
                            candidate['name']!,
                            candidate['jobTitle']!,
                            candidate['appliedDate']!,
                            candidate['interviewDate']!,
                            candidate['interviewPlace']!,
                            candidate['imageUrl']!,
                            false,
                            isPendingInterview,
                            listIndex: currentIndex,
                            candidateIndex: index);
                      },
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          activeJobPostings()
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget activeJobPostings() {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      FutureBuilder<List<Map<String, dynamic>>>(
        future: _jobsRepository.getJobsByCompanyId(widget.id), 
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); 
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No job postings available'));
          }
          List<Map<String, dynamic>> featuredJobs = snapshot.data!;
          return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredJobs.length,
            itemBuilder: (context, index) {
              final job = featuredJobs[index];
              List<String> jobDetails = [job['job_category'], job['job_sub_category'], job['job_type']];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF356899),
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
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: _company['company_logo'] != null
                                  ? MemoryImage(base64Decode(_company['company_logo']))
                                  : const AssetImage('assets/icon.png') as ImageProvider,
                                radius: 22,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job['job_title'] ?? 'Job Title',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _company['company_name'] ?? 'Company Name',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Center(
                            child: Wrap(
                              spacing: 20,
                              children: jobDetails
                                    .map<Widget>(
                                      (tag) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          tag,
                                          style: const TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            '${job['salary_upper_bound']?.toString() ?? 'Salary'} DZD/month',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            job['job_location'] ?? 'Location',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
        } 

        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                color: AppColors.blueButtonColor,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                BottomDialog.show(
                  context,
                  const NotificationsScreen(
                    isCompany: true,
                  ),
                );
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF94969D),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            generateNotificationTile("New Job Application"),
            generateNotificationTile("Scheduled Interview Reminder"),
            generateNotificationTile("New Job Application"),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Text(
              'Recommended Candidates',
              style: TextStyle(
                color: AppColors.blueButtonColor,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
        setState(() {
          currentIndex = 1;
        });
      },
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF94969D),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            buildCandidateTile(
                RecommendedCandidatesList[0]['name']!,
                RecommendedCandidatesList[0]['jobTitle']!,
                RecommendedCandidatesList[0]['appliedDate']!,
                RecommendedCandidatesList[0]['imageUrl']!,
                "",
                "",
                true,
                false),
            buildCandidateTile(
                RecommendedCandidatesList[1]['name']!,
                RecommendedCandidatesList[1]['jobTitle']!,
                RecommendedCandidatesList[1]['appliedDate']!,
                "",
                "",
                RecommendedCandidatesList[1]['imageUrl']!,
                true,
                false),
            buildCandidateTile(
                RecommendedCandidatesList[2]['name']!,
                RecommendedCandidatesList[2]['jobTitle']!,
                RecommendedCandidatesList[2]['appliedDate']!,
                "",
                "",
                RecommendedCandidatesList[2]['imageUrl']!,
                true,
                false),
          ],
        ),
      ],
    );
  }

  Widget generateNotificationTile(String title) {
    return Container(
      width: AppSizes.getScreenWidth(context) * 0.95,
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
      child: Row(
        children: [
          const Text("🔔"),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.blackTextColor,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
