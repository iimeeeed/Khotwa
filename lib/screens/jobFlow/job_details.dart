import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import 'package:khotwa/screens/jobFlow/job_application.dart';
import 'package:khotwa/screens/jobSeeker/homePage.dart';
import '../../backend/repository/jobs_repository.dart';

class JobDetailsApp extends StatelessWidget {
  final int id; // id for fetching job details
  const JobDetailsApp({super.key, this.id = 1}); // Default id for testing

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobDetailsPage(jobId: id),
    );
  }
}

class JobDetailsPage extends StatefulWidget {
  final int jobId; // Added jobId property

  const JobDetailsPage({super.key, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final JobsRepository _jobRepository = JobsRepository();
  Map<String, dynamic>? jobpost; // Store job data
  bool isDescriptionTab = true; // Tab state
  bool isSaved = false; // Bookmark state
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchJobDetails(); // Fetch job details
  }

  // Fetch the job details based on the id
  Future<void> _fetchJobDetails() async {
    final jobData = await _jobRepository.getById(widget.jobId);
    setState(() {
      jobpost = jobData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : jobpost == null
              ? const Center(child: Text('Failed to load job details'))
              : SingleChildScrollView(
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const JobseekerHome(id: 1,)),
                  );
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
            child: jobpost!['logo'] != null
                ? Image.network(jobpost!['logo'], fit: BoxFit.cover)
                : const Icon(Icons.business, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            jobpost!['title'] ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            jobpost!['company'] ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ...?jobpost!['tags']?.map((tag) => Chip(
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
                jobpost!['salary'] ?? '',
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
                jobpost!['location'] ?? '',
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
        Text(jobpost!['description'] ?? '',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 16),
        const Text(
          "Responsibilities:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...?jobpost!['responsibilities']
            ?.map((responsibility) => _buildListItem(responsibility)),
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
        ...?jobpost!['requirements']
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
                builder: (context) => JobApplicationPage(job: jobpost!),
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
