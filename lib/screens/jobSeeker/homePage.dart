import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/search_bar.dart';
import 'package:khotwa/commons/constants.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'package:khotwa/screens/jobFlow/job_details.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final List<Map<String, dynamic>> featuredJobs = [
    {
      'title': 'Product Designer',
      'company': 'SONATRACH',
      'salary': '600,000 DA/y',
      'location': 'Algiers',
      'tags': ['Design', 'Full-Time', 'Junior'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Development'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Development'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Development'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Development'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Development'],
      'logo': 'assets/Sonatrach-Logo.png',
    },
  ];

  List<String> categories = [
    "All jobs",
    "Design",
    "Product management",
    "Developement",
    "Marketing"
  ];

  late List<bool> selectedCategories;

  @override
  void initState() {
    super.initState();
    selectedCategories =
        List.generate(categories.length, (index) => index == 0);
  }

  void toggleCategory(int index) {
    setState(() {
      selectedCategories = List.filled(categories.length, false);
      selectedCategories[index] = true;
    });
  }

  Widget buildTile(
      String str, String job, String employer, String price, String location) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsPage(job: {
              'title': job,
              'company': employer,
              'salary': price,
              'location': location,
              'tags': [],
              'logo': str,
            }),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: AppSizes.getScreenHeight(context) * 0.08,
        width: AppSizes.getScreenWidth(context) * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                child: Image.asset(str),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job,
                    style: TextStyle(
                      fontFamily: AppFonts.secondaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    employer,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFonts.secondaryFont,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.secondaryFont,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryBackgroundColor,
        actions: const [
          KhotwaLogo(),
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/zinebPic.png"),
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
                      "Zineb Berrekia 👋",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            SearchFilterBar(
              hint: "Search a job or a position",
            ),
            const SizedBox(height: 16),

            // Featured Jobs Section
            const Text(
              "Featured Jobs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Job Cards with partial visibility of the next card
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction:
                      0.75, // Adjust this to tweak the visible fraction
                  initialPage: 0,
                ),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: featuredJobs.length,
                itemBuilder: (context, index) {
                  final job = featuredJobs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobDetailsPage(job: job)),
                      );
                    },
                    child: Container(
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
                                    backgroundColor:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    radius: 16,
                                    backgroundImage:
                                        AssetImage(job['logo'] ?? ''),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    job['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            job['company'],
                            style: const TextStyle(color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: job['tags']
                                .map<Widget>(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      tag,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                job['salary'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                job['location'],
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

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredJobs.length,
                (dotIndex) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotIndex == currentIndex
                        ? Colors.blue[900]
                        : Colors.blue[200],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.04,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () => toggleCategory(index),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: AppSizes.getScreenWidth(context) * 0.03),
                    padding: const EdgeInsets.only(
                        top: 7, bottom: 7, right: 14, left: 14),
                    decoration: BoxDecoration(
                      color: selectedCategories[index]
                          ? AppColors.blueButtonColor
                          : Colors.white,
                      border: Border.all(
                        width: 0.7,
                        color: AppColors.blueButtonColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategories[index]
                              ? Colors.white
                              : AppColors.blueButtonColor,
                          fontFamily: AppFonts.secondaryFont,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              })),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.03,
            ),
            const Text(
              "Popular jobs",
              style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.02,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: featuredJobs.map((job) {
                    return buildTile(
                      job['logo'] ?? '',
                      job['title'],
                      job['company'],
                      job['salary'],
                      job['location'],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
