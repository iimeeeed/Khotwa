import 'package:flutter/material.dart';
import '../../../commons/khotwa_logo.dart';

class Flow extends StatefulWidget {
  const Flow({super.key});

  @override
  State<Flow> createState() => _FlowState();
}

class _FlowState extends State<Flow> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  Map<String, String> myMap = {
    "assets/asset3.png":
        "Figure out your top five priorities whether it is company culture, salary.",
    "assets/asset4.png":
        "Our job list includes several industries, so you can find the best job for you.",
    "assets/asset5.png":
        "You can apply to your desirable jobs very quickly and easily with ease.",
    "assets/asset6.png":
        "We help you find your dream job based on your skillset, location, demand.",
  };

  List<String> myList = [
    "Search your job",
    "Browse jobs list",
    "Apply to test jobs",
    "Make your career"
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF3F2),
        automaticallyImplyLeading: false,
        actions: const [KhotwaLogo()],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: myMap.length,
              itemBuilder: (context, index) {
                String imagePath = myMap.keys.elementAt(index);
                String description = myMap[imagePath]!;
                String title = myList[index];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 120),
                      Hero(
                        tag: imagePath,
                        child: SizedBox(
                            width: 250,
                            height: 250,
                            child: Image.asset(imagePath)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "Khmer MN",
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF95969D),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(myList.length, (index) {
                double tweenStart = currentPage == index ? 27 : 8;
                double tweenEnd = currentPage == index ? 27 : 8;

                if (currentPage < index) {
                  tweenStart = 8;
                } else if (currentPage > index) {
                  tweenStart = 27;
                }

                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: tweenStart, end: tweenEnd),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, double width, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: width,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: currentPage == index
                            ? const Color(0xFF2B557C)
                            : const Color(0xFFE4E5E7),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          currentPage < myList.length - 1
              ? Positioned(
                  bottom: 40,
                  left: 0,
                  right: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Jump to the last page
                          if (currentPage < myMap.length - 1) {
                            _pageController.animateToPage(
                              myMap.length - 1, // Navigate to the last page
                              duration: const Duration(
                                  milliseconds: 300), // Smooth transition
                              curve: Curves
                                  .easeInOut, // Optional curve for a smooth effect
                            );
                          }
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              color: Color.fromARGB(255, 137, 137, 141)),
                        ),
                      )
                    ],
                  ))
              : Positioned(
                  bottom: 30,
                  right: 30,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF2C557D)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Explore",
                            style: TextStyle(color: Colors.white),
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
}
