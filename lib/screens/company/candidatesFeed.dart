import 'package:flutter/material.dart';
import '../../data/candidates_data.dart';
import '../../commons/constants.dart';

class CandidatesFeed extends StatefulWidget {
  const CandidatesFeed({super.key});

  @override
  _CandidatesFeedState createState() => _CandidatesFeedState();
}

class _CandidatesFeedState extends State<CandidatesFeed> {
  int currentIndex = 0; // Track the active card index
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
            side: const BorderSide(width: 0.50, color: Color(0xFF1B4174)),
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
      String name, String jobTitle, String appliedDate, String imageUrl) {
    return Container(
      width: 326,
      height: 118,
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
                          side: BorderSide(width: 1, color: Color(0xFF1B4174)),
                        ),
                      ),
                      child: const Icon(Icons.phone,
                          size: 20, color: Color(0xFF1B4174)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(
                          side: BorderSide(width: 1, color: Color(0xFF1B4174)),
                        ),
                      ),
                      child: const Icon(Icons.email,
                          size: 20, color: Color(0xFF1B4174)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(color: Color(0xFFAAAFBB), height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
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
                  child: Container(
                    width: 68,
                    height: 21,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF84BDA9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F2),
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
                  color: Color(0xFF1B4174),
                  fontFamily: "Khmer MN",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Welcome Header
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    child: const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xFF95969D)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 44,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      const Icon(Icons.filter_list, color: Color(0xFF95969D)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 254,
              child: Text(
                'Candidates',
                style: TextStyle(
                  color: Color(0xFF1B4174),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.07,
                  letterSpacing: -0.27,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Card Slider (Horizontal Scrollable)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCard(
                    'Active Job Postings',
                    0,
                    backgroundColor: currentIndex == 0
                        ? const Color(0xFF1A3D6C)
                        : const Color(0xFFEFF3F2),
                    textColor: currentIndex == 0
                        ? Colors.white
                        : const Color(0xFF1B4174),
                  ),
                  const SizedBox(width: 10),
                  buildCard(
                    'New Applicants',
                    1,
                    backgroundColor: currentIndex == 1
                        ? const Color(0xFF1A3D6C)
                        : const Color(0xFFEFF3F2),
                    textColor: currentIndex == 1
                        ? Colors.white
                        : const Color(0xFF1B4174),
                  ),
                  const SizedBox(width: 10),
                  buildCard(
                    'Pending Interviews',
                    2,
                    backgroundColor: currentIndex == 2
                        ? const Color(0xFF1A3D6C)
                        : Colors.transparent,
                    textColor: currentIndex == 2
                        ? Colors.white
                        : const Color(0xFF1A3D6C),
                  ),
                  const SizedBox(width: 10),
                  buildCard(
                    'Shortlisted Candidates',
                    3,
                    backgroundColor: currentIndex == 3
                        ? const Color(0xFF1A3D6C)
                        : Colors.transparent,
                    textColor: currentIndex == 3
                        ? Colors.white
                        : const Color(0xFF1A3D6C),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: candidatesList[currentIndex].length,
                itemBuilder: (context, index) {
                  final candidate = candidatesList[currentIndex][index];
                  return buildCandidateTile(
                      candidate['name']!,
                      candidate['jobTitle']!,
                      candidate['appliedDate']!,
                      candidate['imageUrl']!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
