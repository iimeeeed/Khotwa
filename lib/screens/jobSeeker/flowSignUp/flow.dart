import 'package:flutter/material.dart';
import '../../../commons/khotwa_logo.dart';
import '../../../commons/constants.dart';
import '../preferences/prefs.dart';

class Flow extends StatefulWidget {
  final int id;
  final String email;
  const Flow({super.key, required this.id, required this.email});

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
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
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
                      SizedBox(height: AppSizes.getScreenHeight(context) * 0.1),
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
                            fontFamily: AppFonts.primaryFont,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.02),
                      SizedBox(
                        width: 300,
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppFonts.secondaryFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: AppSizes.getScreenHeight(context) * 0.6),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: AppSizes.getScreenHeight(context) * 0.15,
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
                            ? AppColors.blueButtonColor
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
                          if (currentPage < myMap.length - 1) {
                            _pageController.animateToPage(
                              myMap.length - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.secondaryFont,
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
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                AppColors.blueButtonColor),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Prefs(
                                  id: widget.id,
                                  email: widget.email,
                                ),
                              ),
                            );
                          },
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
