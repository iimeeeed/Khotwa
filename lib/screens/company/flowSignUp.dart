import 'package:flutter/material.dart';
import 'package:khotwa/screens/company/company_verification.dart';
import '../../../commons/khotwa_logo.dart';
import '../../../commons/constants.dart';

class FlowCompany extends StatefulWidget {
  final Map<String, dynamic> companyData ;
  const FlowCompany({super.key, required this.companyData});

  @override
  State<FlowCompany> createState() => _FlowCompanyState();
}

class _FlowCompanyState extends State<FlowCompany> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  Map<String, String> myMap = {
    "assets/asset7.png":
        "Away from you desk ? No problem. Our mobile app gives you access to everything you need to make hiring decisions on the go.",
    "assets/asset8.png":
        "Simply enter the job title, describe the role and its responsibilities, and list required skills. It's as straightforward as that!",
    "assets/asset9.png":
        "Browse through profiles, filter by skills or experience, and find the perfect match for your job. It's effortless and efficient!",
  };

  List<String> myList = [
    "Hire From Anywhere",
    "Describe your job",
    "Search Some Talents",
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
                        width: AppSizes.getScreenWidth(context),
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
                          height: AppSizes.getScreenHeight(context) * 0.04),
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
                          height: AppSizes.getScreenHeight(context) * 0.4),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom:AppSizes.getScreenHeight(context)*0.15,


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
                                    builder: (context) => CompanyVerificationPage(companyData: widget.companyData,)));
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