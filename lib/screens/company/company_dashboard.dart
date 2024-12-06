import 'package:flutter/material.dart';
import '../../commons/khotwa_logo.dart';
import '../../commons/constants.dart';
import '../../widgets/bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      bottomNavigationBar: const BottomBar(isJobseeker: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topRight,
                child: KhotwaLogo(),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          "assets/Sonatrach-Logo.png",
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
                            "Sonatrach 👋",
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
              SizedBox(
                width: double.infinity,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.blueButtonColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: AppSizes.getScreenWidth(context)*0.126),
                    const Text(
                      'Company Dashboard',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blueButtonColor,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.08,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProgressIndicator(
                          progressValue: 20,
                          label: "posts",
                          title: "Job Posted",
                        ),
                        ProgressIndicator(
                          progressValue: 42,
                          label: "apps",
                          title: "Total Applications",
                        ),
                        ProgressIndicator(
                          progressValue: 7,
                          label: "jobs",
                          title: "Saved Jobs",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    children: [
                      Text(
                        'Weekly Overview',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blueButtonColor,
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: BarChartProgress(
                          typeOfUse: true,
                          barChartColor: AppColors.lightGreenColor,
                          lineChartColor: AppColors.blueButtonColor,
                          maxValuesY: 10,
                          values: [
                            [0, 1, 2, 3, 4, 5, 6], // X values
                            [5, 7, 3, 8, 4, 3, 10] // Y values
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightGreenColor,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'is the highest number of applications during this week',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  final double progressValue; // 0 to 100
  final String label;
  final String title;

  const ProgressIndicator({
    super.key,
    required this.progressValue,
    required this.label,
    required this.title,
  });

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double currentProgress = 0;

  @override
  void initState() {
    super.initState();
    currentProgress = widget.progressValue;

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: currentProgress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  void updateProgress(double newProgress) {
    setState(() {
      currentProgress = newProgress;
      _animation =
          Tween<double>(begin: _animation.value, end: currentProgress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller
        ..reset()
        ..forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.blueButtonColor,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return CustomPaint(
              size: const Size(80, 80),
              painter: ThreeQuarterCirclePainter(
                progress: _animation.value / 100,
                progressColor: _getProgressColor(_animation.value),
                backgroundColor: Colors.grey.shade300,
                lineWidth: 10,
                backgroundWidth: 6,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_animation.value.toInt()}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getProgressColor(double progressValue) {
    if (progressValue < 10) {
      return AppColors.secondaryButtonColor;
    } else if (progressValue < 40) {
      return AppColors.lightGreenColor;
    } else {
      return AppColors.blueButtonColor;
    }
  }
}

class ThreeQuarterCirclePainter extends CustomPainter {
  final double progress; // Between 0 and 1
  final Color progressColor;
  final Color backgroundColor;
  final double lineWidth;
  final double backgroundWidth;

  ThreeQuarterCirclePainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.lineWidth,
    required this.backgroundWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double radius = 37;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = backgroundWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * 3.14 / 4, // Start angle
      3 * 3.14 / 2, // Sweep angle
      false,
      backgroundPaint,
    );

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        3 * 3.14 / 4,
        progress * (3 * 3.14 / 2),
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

List<String> daysList = [
  "Sat",
  "Sun",
  "Mon",
  "Thu",
  "Wed",
  "Tue",
  "Fri",
];

class BarChartProgress extends StatefulWidget {
  final double maxValuesY;
  final List<List<double>> values; // Format: [[x values], [y values]]
  final Color barChartColor;
  final Color lineChartColor;
  final bool
      typeOfUse; // false: weekly progress (percentage), true: monthly progress (raw values)

  const BarChartProgress({
    super.key,
    required this.typeOfUse,
    required this.barChartColor,
    required this.lineChartColor,
    required this.maxValuesY,
    required this.values,
  });

  @override
  _BarChartProgressState createState() => _BarChartProgressState();
}

class _BarChartProgressState extends State<BarChartProgress>
    with SingleTickerProviderStateMixin {
  late List<double> normalizedYValues;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeValues();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant BarChartProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart animation if widget updates
    if (widget.values != oldWidget.values ||
        widget.typeOfUse != oldWidget.typeOfUse) {
      _initializeValues();
      _controller.reset();
      _controller.forward();
    }
  }

  void _initializeValues() {
    normalizedYValues = widget.typeOfUse
        ? widget.values[1]
        : widget.values[1].map((y) => (y / widget.maxValuesY) * 100).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double adjustedMaxY = widget.typeOfUse ? widget.maxValuesY : 10;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animatedYValues =
            normalizedYValues.map((y) => y * _animation.value).toList();

        return SizedBox(
          width: 350,
          height: 243,
          child: Center(
            child: Stack(
              children: [
                // Bar Chart
                SizedBox(
                  width: 320,
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      maxY: adjustedMaxY,
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              return Text(
                                widget.typeOfUse
                                    ? daysList[index]
                                    : index.toString(),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              if (!widget.typeOfUse) {
                                return Text(
                                  '${value.toInt()}%',
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return Text(
                                  value.toStringAsFixed(0),
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        for (int i = 0; i < widget.values[0].length; i++)
                          BarChartGroupData(
                            x: widget.values[0][i].toInt(),
                            barRods: [
                              BarChartRodData(
                                toY: animatedYValues[i],
                                color: widget.barChartColor,
                                width: 14,
                                borderRadius: BorderRadius.zero,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                // Line Chart
                Positioned(
                  left: 70,
                  child: SizedBox(
                    width: AppSizes.getScreenWidth(context)*0.575,
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        maxY: adjustedMaxY,
                        minY: 0,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              for (int i = 0; i < widget.values[0].length; i++)
                                FlSpot(
                                  widget.values[0][i],
                                  animatedYValues[i],
                                ),
                            ],
                            isCurved: true,
                            color: widget.lineChartColor,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                            barWidth: 2,
                          ),
                        ],
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.transparent),
                            bottom: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        titlesData: const FlTitlesData(show: false),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
