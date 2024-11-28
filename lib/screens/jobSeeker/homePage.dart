import 'package:flutter/material.dart';


class JobSearchApp extends StatelessWidget {
  const JobSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobSearchPage(),
    );
  }
}

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
      'logo': 'https://via.placeholder.com/50',
    },
    {
      'title': 'Frontend Developer',
      'company': 'Google',
      'salary': '160,000/year',
      'location': 'Remote',
      'tags': ['Design'],
      'logo': 'https://via.placeholder.com/50', // Placeholder logo
    },
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
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
                      backgroundImage: NetworkImage(
                        "https://via.placeholder.com/150", // Placeholder profile image
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
                          "Zineb Berrekia 👋",
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search a job or position",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Featured Jobs Section
            const Text(
              "Featured Jobs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Job Cards
            SizedBox(
  height: 160,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: featuredJobs.length,
    itemBuilder: (context, index) {
      final job = featuredJobs[index];
      return GestureDetector(
        onTap: () {
         
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75, // Reduced width
          margin: const EdgeInsets.only(right: 12), // Spacing between cards
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF356899), // Blue background
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
              // Top Row: Logo, Title, and Favorite Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Placeholder for Logo
                      const CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        radius: 16,
                        child: Icon(Icons.business, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        job['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white, // White icon
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Company Name
              Text(
                job['company'],
                style: const TextStyle(color: Colors.white70), // Lighter white text
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Tags
              Wrap(
                spacing: 8,
                children: job['tags']
                    .map<Widget>(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white24, // Light blue background
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            
              const SizedBox(height: 8),
              // Salary and Location
              Row(
                children: [
                  Text(
                    job['salary'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                  const Spacer(),
                  Text(
                job['location'],
                style: const TextStyle(color: Colors.white70), // Lighter white text
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

// Navigation Dots
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    4, // Always 4 dots
    (dotIndex) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotIndex == 0
            ? Colors.blue[900] // Highlighted dot
            : Colors.blue[200], // Non-highlighted dots
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
