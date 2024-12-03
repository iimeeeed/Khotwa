import 'package:flutter/material.dart';
import '../../data/candidates_data.dart';
import '../../commons/constants.dart';

class CandidatesDetails extends StatefulWidget {
  final List<int> candidateId;

  const CandidatesDetails({super.key, required this.candidateId});

  @override
  State<CandidatesDetails> createState() => _CandidatesDetailsState();
}

class _CandidatesDetailsState extends State<CandidatesDetails> {
  AppColors colors = AppColors();

  Widget progressIem(String txt, bool filled) {
    return Container(
      width: 74,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: (filled) ? const Color(0xFF1B4174) : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF1B4174), width: 0.5),
          borderRadius: BorderRadius.circular(97),
        ),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: (filled) ? Colors.white : const Color(0xFF1B4174),
            fontSize: 8,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.2,
            letterSpacing: -0.09,
          ),
        ),
      ),
    );
  }

  Widget buildCandidateTile(
      String name, String jobTitle, String appliedDate, String imageUrl) {
    return Container(
      width: 326,
      height: 130,
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
            height: 5,
          ),
          const Divider(color: Color(0xFFAAAFBB), height: 0.8, thickness: 1),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressIem("Submitted", true),
                progressIem("Seen", true),
                progressIem("Interviewed", false),
                progressIem("Accepted", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final candidate =
        candidatesData[widget.candidateId[0]][widget.candidateId[1]];
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F2),
      body: SingleChildScrollView(
        child: Padding(
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

              // Candidate Details
              SizedBox(
                width: 366,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF1B4174),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 69),
                    const Text(
                      'Candidate Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1B4174),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.08,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              buildCandidateTile(
                candidate['name']!,
                candidate['jobTitle']!,
                candidate['appliedDate']!,
                candidate['imageUrl']!,
              ),
              CandidateDetails(candidate: candidate),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 266,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF84BDA9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Center(
                    child: Text(
                      'Plan Interview',
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

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CandidateDetails extends StatelessWidget {
  final Map<String, dynamic> candidate;

  const CandidateDetails({
    super.key,
    required this.candidate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 280,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: Color(0xFF84BDA9),
                labelColor: Color(0xFF84BDA9),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Personal Info'),
                  Tab(text: 'Skills & Experiences'),
                  Tab(text: 'Documents'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPersonalInfo(candidate),
                  _buildSkillsAndExperiences(candidate),
                  _buildDocuments(candidate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(Map<String, dynamic> candidate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('Full Name', candidate['name']!),
          _buildInfoItem('Email', candidate['email']!),
          _buildInfoItem('Phone Number', candidate['phone']!),
          _buildInfoItem('Address', candidate['address']!),
        ],
      ),
    );
  }

  Widget _buildSkillsAndExperiences(Map<String, dynamic> candidate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('Skills', candidate['skills']!),
          _buildInfoItem('Experience', candidate['experience']!),
        ],
      ),
    );
  }

  Widget _buildDocuments(Map<String, dynamic> candidate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('Resume', candidate['resume']!),
          _buildInfoItem('Certificates', candidate['certificates']!),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF787878),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF3F4245),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
