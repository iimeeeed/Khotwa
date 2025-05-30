import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:khotwa/screens/jobFlow/success_dialog.dart';
import 'package:khotwa/screens/jobFlow/track_application.dart';

class JobApplicationPage extends StatefulWidget {
  final Map<String, dynamic> job;

  const JobApplicationPage({super.key, required this.job});

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  String? cvPath;
  String? motivationPath;
  final portfolioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button and Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF002D62)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Apply Job',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Curriculum Vitae',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // CV Upload Section
                      _buildUploadSection(
                        hint: 'Upload your CV Here',
                        fileName: cvPath != null ? 'CV zineb berrekia.pdf' : null,
                        fileSize: '10KB',
                        onUpload: () {
                          // Implement file picking logic
                          setState(() {
                            cvPath = 'dummy_path';
                          });
                        },
                        onDelete: cvPath != null ? () {
                          setState(() {
                            cvPath = null;
                          });
                        } : null,
                      ),
                      const SizedBox(height: 24),
                      
                      const Text(
                        'Motivation',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Motivation Upload Section
                      _buildUploadSection(
                        hint: 'Write here your motivation',
                        fileName: motivationPath != null ? 'Motivation' : null,
                        fileSize: '10KB',
                        onUpload: () {
                          setState(() {
                            motivationPath = 'dummy_path';
                          });
                        },
                        onDelete: motivationPath != null ? () {
                          setState(() {
                            motivationPath = null;
                          });
                        } : null,
                      ),
                      const SizedBox(height: 24),
                      
                      Text(
                        'Portfolio (optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Portfolio URL Input
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: portfolioController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'https://',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Apply Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show the success dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SuccessDialog(
                          onClose: () {
                            // Navigate to home and clear the stack
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', // Replace with your home route name
                              (Route<dynamic> route) => false,
                            );
                          },
                          onTrackApplication: () {
                            // Navigate to track application page
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => TrackApplicationPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002D62),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Send Apply",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection({
    required String hint,
    String? fileName,
    String? fileSize,
    required VoidCallback onUpload,
    VoidCallback? onDelete,
  }) {
    return Column(
      children: [
         DottedBorder(
        color: Colors.grey.shade300,  // Border color
        strokeWidth: 2,  // Width of the dotted lines
        dashPattern: const [6, 3],  // Pattern for the dots (6 pixels line, 3 pixels gap)
        borderType: BorderType.RRect,  // Rounded rectangle border
        radius: const Radius.circular(8),  // Corner radius
        child: InkWell(
          onTap: onUpload,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_file, color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  hint,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
        if (fileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Icon(Icons.description, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fileName),
                      Text(fileSize ?? '', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
