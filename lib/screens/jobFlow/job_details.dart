import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import 'package:khotwa/screens/jobFlow/job_application.dart';
import 'package:khotwa/screens/jobSeeker/homePage.dart';

class JobDetailsApp extends StatelessWidget {
  const JobDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    const sampleJob = {
      'logo': 'assets/Sonatrach-Logo.png',
      'title': 'Software Engineer',
      'company': 'Tech Innovators Inc.',
      'tags': ['Full-time', 'Remote', 'IT'],
      'salary': '80,000DZD/year',
      'location': 'San Francisco, CA',
      'description':
          'We are looking for a Software Engineer to join our team...',
      'responsibilities': [
        'Develop high-quality software solutions.',
        'Collaborate with cross-functional teams.',
        'Maintain and improve code quality and documentation.',
        'Participate in code reviews and provide constructive feedback.'
      ],
      'address': '123 Silicon Valley Blvd, San Francisco, CA 94016',
      'facilities': [
        'Flexible work hours',
        'Health insurance',
        'Free lunch and snacks',
        'Annual company retreat'
      ],
      'requirements': [
        'Bachelors degree in Computer Science or related field.',
        'Proficiency in programming languages like Dart, Java, or Python.',
        'Experience with Flutter is a plus.',
        'Excellent problem-solving skills and teamwork.',
        'Strong communication skills.'
      ]
    };

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobDetailsPage(job: sampleJob),
    );
  }
}

class JobDetailsPage extends StatefulWidget {
  final Map<String, dynamic> job;
  const JobDetailsPage({super.key, required this.job});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  bool isDescriptionTab = true;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            _buildTabContent(),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.blueButtonColor,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
      child: Column(
        children: [
          // Back and bookmark icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const JobseekerHome()));
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
                child: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Logo, title, and company name
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: widget.job['logo'] != null
                ? Image.asset(widget.job['logo'], fit: BoxFit.cover)
                : const Icon(Icons.business, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            widget.job['title'] ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            widget.job['company'] ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ...?widget.job['tags']?.map((tag) => Chip(
                    label: Text(
                      tag,
                      style: const TextStyle(color: AppColors.blueButtonColor),
                    ),
                    backgroundColor: AppColors.primaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.job['salary'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.location_on, color: AppColors.lightGreenColor),
              const SizedBox(width: 4),
              Text(
                widget.job['location'] ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Spacer(),
          _buildTab('Description', isDescriptionTab, () {
            setState(() => isDescriptionTab = true);
          }),
          const Spacer(),
          const SizedBox(width: 32),
          _buildTab('Requirement', !isDescriptionTab, () {
            setState(() => isDescriptionTab = false);
          }),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? AppColors.blueButtonColor : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          if (isActive) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.blueButtonColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: isDescriptionTab
          ? _buildDescriptionContent()
          : _buildRequirementContent(),
    );
  }

  Widget _buildDescriptionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.job['description'] ?? '',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 24),
        const Text(
          "Responsibilities:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...?widget.job['responsibilities']
            ?.map((responsibility) => _buildListItem(responsibility)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: AppColors.lightGreenColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                widget.job['address'] ?? '',
                style: const TextStyle(color: AppColors.greyTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            height: 200,
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/map.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                const Icon(Icons.map, size: 48, color: Colors.red),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Facilities and Others:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...?widget.job['facilities']
            ?.map((facility) => _buildListItem(facility)),
      ],
    );
  }

  Widget _buildRequirementContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Requirements:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...?widget.job['requirements']
            ?.map((requirement) => _buildListItem(requirement)),
      ],
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobApplicationPage(job: widget.job),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueButtonColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Apply Now",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
