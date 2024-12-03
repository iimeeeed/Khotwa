import 'package:flutter/material.dart';
import '../../data/candidates_data.dart';
import '../../widgets/search_bar.dart';
import 'package:khotwa/commons/constants.dart';
import 'package:khotwa/commons/khotwa_logo.dart';
import 'package:khotwa/screens/jobFlow/job_details.dart';

class JobseekerHome extends StatefulWidget {
  const JobseekerHome({super.key});

  @override
  _JobseekerHomeState createState() => _JobseekerHomeState();
}

class _JobseekerHomeState extends State<JobseekerHome> {
  List<String> categories = [
    "All jobs",
    "Design",
    "Product management",
    "Developement",
    "Marketing"
  ];

  late List<bool> selectedCategories;
  int currentIndex = 0;
  bool isSaved = false;

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
              'tags': const [],
              'logo': str,
            }),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/Sonatrach-Logo.png"),
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
                    style: const TextStyle(
                      fontFamily: AppFonts.secondaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    employer,
                    style: const TextStyle(
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
                  style: const TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: const TextStyle(
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
            const SearchFilterBar(
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredJobs.length,
                itemBuilder: (context, index) {
                  final job = featuredJobs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobDetailsApp()));
                    },
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
                                      image: AssetImage(
                                          "assets/Sonatrach-Logo.png"),
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
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        job['company'] ?? 'Company Name',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  isSaved = !isSaved;
                                  setState(() {
                                    
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Icon(
                                    (!isSaved)
                                        ? Icons.bookmark_add_outlined
                                        : Icons.bookmark,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              )
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            tag ?? 'Tag',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
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
