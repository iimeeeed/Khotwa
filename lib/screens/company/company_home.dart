import 'package:flutter/material.dart';
import '../../data/candidates_data.dart';
import '../../commons/constants.dart';
import 'candidatesDetails.dart';
import 'notifications.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/search_bar.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  _CompanyHomeState createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  int currentIndex = 0;
  AppColors colors = AppColors();

  List<List<Map<String, String>>> candidatesList = candidatesData;

  //Function to create the candidate card
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

  // Function to create the candidate list tiles
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
                                    fontSize: 9,
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
                                      width: 68,
                                      height: 21,
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
                                            fontSize: 7,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      bottomNavigationBar: const BottomBar(isJobseeker: false),
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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/Sonatrach-Logo.png",
                      ),
                      radius: 24,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "Sonatrach 👋",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search Bar
            (currentIndex > 0)
                ? const SearchFilterBar()
                : Container(
                    child: const Text(
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
            const SizedBox(height: 30),
            const SizedBox(
              width: 254,
              child: Text(
                'Candidates',
                style: TextStyle(
                  color: AppColors.blueButtonColor,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.07,
                  letterSpacing: -0.27,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                          activeJobPostings(),
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
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredJobs.length,
            itemBuilder: (context, index) {
              final job = featuredJobs[index];
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
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                radius: 22,
                                child: Image(
                                  image:
                                      AssetImage("assets/Sonatrach-Logo.png"),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job['title'] ?? 'Job Title',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    job['company'] ?? 'Company Name',
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
                              children: (job['tags'] as List)
                                  .map<Widget>(
                                    (tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        tag ?? 'Tag',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
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
                            job['salary'] ?? 'Salary',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            job['location'] ?? 'Location',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notifications(),
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
              onTap: () {},
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
