import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobSeeker/homePage.dart';

class TrackApplicationPage extends StatelessWidget {
  final Map<String, dynamic> applicationSteps = {
    'Application submitted': {
      'date': '17/05/22',
      'time': '11:00 am',
      'isCompleted': true,
      'isCurrent': false,
    },
    'Reviewed by Sonatrach team': {
      'date': '25/05/22',
      'time': '09:00 am',
      'isCompleted': true,
      'isCurrent': false,
    },
    'Application Accepted': {
      'date': '05/06/22',
      'time': '11:00 am',
      'isCompleted': true,
      'isCurrent': false,
    },
    'Interview Scheduled': {
      'date': '05/06/22',
      'time': '11:00 am',
      'isCompleted': true,
      'isCurrent': true,
    },
    'Offer letter': {
      'date': '',
      'time': '',
      'isCompleted': false,
      'isCurrent': false,
    },
  };

  TrackApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Applied Job Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Header
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.business, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Designer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Spotify',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      '\$88,000/y',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        'Los Angels, US',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Track Application',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Timeline
            Expanded(
              child: _buildTimeline(),
            ),
            // Browse Jobs Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JobseekerHome(id: 1,)),
    );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF002D62)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Browse Jobs',
                  style: TextStyle(
                    color: Color(0xFF002D62),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    // Reversing the steps to show in reverse order
    List<String> reversedSteps = applicationSteps.keys.toList().reversed.toList();
    
    return ListView.builder(
      itemCount: reversedSteps.length,
      itemBuilder: (context, index) {
        String stepTitle = reversedSteps[index];
        Map<String, dynamic> stepData = applicationSteps[stepTitle]!;
        bool isLast = index == reversedSteps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline line and dot
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: stepData['isCompleted']
                            ? const Color(0xFF002D62)
                            : Colors.grey[300],
                        border: Border.all(
                          color: stepData['isCompleted']
                              ? const Color(0xFF002D62)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: stepData['isCompleted']
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : null,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: stepData['isCompleted']
                              ? const Color(0xFF002D62)
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              ),
              // Step content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stepTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (stepData['date'].isNotEmpty)
                        Text(
                          '${stepData['date']}    ${stepData['time']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        )
                      else
                        Text(
                          'Not yet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
