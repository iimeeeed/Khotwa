import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobFlow/job_application.dart';

void main() {
  runApp(JobDetailsApp());
}

class JobDetailsApp extends StatelessWidget {
  const JobDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobDetailsPage(
        job: {},
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue background container
            Container(
              color: const Color(0xFF002D62),
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
                          Navigator.pop(
                              context); // This will navigate back to the previous page
                        },
                      ),
                      const Icon(Icons.bookmark_border, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Logo, title, company
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: widget.job['logo'] != null
                        ? Image.asset(widget.job['logo'],
                            fit: BoxFit.cover) // For local asset image
                        : const Icon(Icons.business,
                            size: 40), // Fallback icon if no logo is provided
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
                  // Tags
                  Wrap(
                    spacing: 8,
                    children: [
                      ...?widget.job['tags']?.map((tag) => Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 63, 72, 108),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        widget.job['salary'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.location_on, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        widget.job['location'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            // Tabs
            Padding(
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
            ),
            // Content based on selected tab
            Padding(
              padding: const EdgeInsets.all(16),
              child: isDescriptionTab
                  ? _buildDescriptionContent()
                  : _buildRequirementContent(),
            ),
            // Apply Now Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            JobApplicationPage(job: widget.job),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002D62),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Apply Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
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
              color: isActive ? const Color(0xFF002D62) : Colors.grey,
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
                color: Color(0xFF002D62),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.job['description'] ?? '',
            style: TextStyle(color: Colors.grey[600])),
        TextButton(
          onPressed: () {},
          child: const Text("Read More.."),
        ),
        const SizedBox(height: 24),
        const Text(
          "Responsibilities:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...?widget.job['responsibilities']
            ?.map((responsibility) => _buildListItem(responsibility)),
        const SizedBox(height: 24),
        const Text(
          "Location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(widget.job['address'] ?? ''),
        const SizedBox(height: 16),
        Container(
          height: 200,
          color: Colors.grey[200],
          child:
              const Center(child: Icon(Icons.map, size: 48, color: Colors.red)),
        ),
        const SizedBox(height: 24),
        const Text(
          "Facilities and Others",
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
        Text(
          "Requirements will go here...",
          style: TextStyle(color: Colors.grey[600]),
        ),
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
}
