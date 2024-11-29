import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobFlow/job_application.dart';

void main() {
  runApp(JobDetailsApp());
}

class JobDetailsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobDetailsPage(
        job: {
          
        },
      ),
    );
  }
}

class JobDetailsPage extends StatefulWidget {
  final Map<String, dynamic> job;
  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

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
              color: Color(0xFF002D62),
              padding: EdgeInsets.fromLTRB(16, 40, 16, 24),
              child: Column(
                children: [
                  // Back and bookmark icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // This will navigate back to the previous page
                        },
                      ),
                      Icon(Icons.bookmark_border, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Logo, title, company
                  CircleAvatar(
  radius: 40,
  backgroundColor: Colors.white,
  child: widget.job['logo'] != null
      ? Image.asset(widget.job['logo'], fit: BoxFit.cover) // For local asset image
      : Icon(Icons.business, size: 40), // Fallback icon if no logo is provided
),

                  SizedBox(height: 16),
                  Text(
                    widget.job['title'] ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.job['company'] ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  // Tags
                  Wrap(
  spacing: 8,
  children: [
    ...?widget.job['tags']?.map((tag) => Chip(
          label: Text(
            tag,
            style: TextStyle(color: Colors.white), 
          ),
          backgroundColor: const Color.fromARGB(255, 63, 72, 108), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), 
          ),
        )),
  ],
),
                  SizedBox(height: 12),
                  
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                    widget.job['salary'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ), Spacer(),
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        widget.job['location'] ?? '',
                        style: TextStyle(color: Colors.white),
                      ),Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            // Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Spacer(),
                  _buildTab('Description', isDescriptionTab, () {
                    setState(() => isDescriptionTab = true);
                  }),Spacer(),
                  SizedBox(width: 32),
                  _buildTab('Requirement', !isDescriptionTab, () {
                    setState(() => isDescriptionTab = false);
                  }),
                  Spacer(),
                ],
              ),
            ),
            // Content based on selected tab
            Padding(
              padding: EdgeInsets.all(16),
              child: isDescriptionTab ? _buildDescriptionContent() : _buildRequirementContent(),
            ),
            // Apply Now Button
            Padding(
              padding: EdgeInsets.all(16),
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
                    backgroundColor: Color(0xFF002D62),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
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
              color: isActive ? Color(0xFF002D62) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          if (isActive) ...[
            SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
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
          child: Text("Read More.."),
        ),
        SizedBox(height: 24),
        Text(
          "Responsibilities:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...?widget.job['responsibilities']?.map((responsibility) => _buildListItem(responsibility)),
        SizedBox(height: 24),
        Text(
          "Location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(widget.job['address'] ?? ''),
        SizedBox(height: 16),
        Container(
          height: 200,
          color: Colors.grey[200],
          child: Center(child: Icon(Icons.map, size: 48, color: Colors.red)),
        ),
        SizedBox(height: 24),
        Text(
          "Facilities and Others",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...?widget.job['facilities']?.map((facility) => _buildListItem(facility)),
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
          Icon(Icons.check, color: Colors.green, size: 20),
          SizedBox(width: 8),
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
