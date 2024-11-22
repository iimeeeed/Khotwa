import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoSlideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoSlideAnimation = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(_logoSlideAnimation.value, 0),
                        child: Image.asset(
                          "assets/khotwaLogo.png",
                          width: 260,
                          height: 251,
                        ),
                      ),
                      Opacity(
                        opacity: _textFadeAnimation.value,
                        child: Transform.translate(
                          offset: const Offset(-55, 85),
                          child: Image.asset(
                            "assets/LandingText.png",
                            width: 200,
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Text(
              "“Believe in the first step to make it true.”",
              style: TextStyle(
                fontFamily: "Khmer MN",
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1B4174),
              ),
              textAlign: TextAlign.center,
            ),
          ),

        
        ],
      ),
    );
  }
}
