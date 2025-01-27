import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:khotwa/backend/repository/job_seekers_repository.dart';
import '../../../commons/constants.dart';
import '../../../commons/khotwa_logo.dart';
import '../homePage.dart';

class Prefs extends StatefulWidget {
  final int id ;
  const Prefs({super.key, required this.id});

  @override
  State<Prefs> createState() => _PrefsState();
}

class _PrefsState extends State<Prefs> {
  final JobSeekersRepository jobseekerRepo = JobSeekersRepository();
  Map<String, bool> prefsChecked = {};

  @override
  void initState() {
    super.initState();
    prefsChecked = {for (var entry in _prefsMap.values) entry: false};
  }

  final Map<Icon, String> _prefsMap = {
    const Icon(Icons.design_services_outlined,
        color: AppColors.blueButtonColor): "Designer",
    const Icon(Icons.developer_mode_outlined, color: AppColors.blueButtonColor):
        "Developer",
    const Icon(Icons.admin_panel_settings_outlined,
        color: AppColors.blueButtonColor): "Administrative",
    const Icon(Icons.sell_outlined, color: AppColors.blueButtonColor):
        "Marketing",
    const Icon(Icons.manage_accounts_outlined,
        color: AppColors.blueButtonColor): "Management",
    const Icon(
      Icons.other_houses_outlined,
      color: AppColors.blueButtonColor,
    ): "Others",
  };

  final List<Map<String, dynamic>> _tags = [
    {"name": "Full-time", "selected": false},
    {"name": "Part-time", "selected": false},
    {"name": "Remote", "selected": false},
    {"name": "Internship", "selected": false},
  ];

  final List<Map<String, dynamic>> _locations = [
    {"name": "Algiers", "selected": false},
    {"name": "Medea", "selected": false},
    {"name": "Tipaza", "selected": false},
    {"name": "Oum el Bouaghi", "selected": false},
    {"name": "Oran", "selected": false},
    {"name": "Tizi Ouzou", "selected": false},
    {"name": "Constantine", "selected": false},
  ];

  bool _showAllTags = false;
  bool _showAllLocations = false;

  bool _others = false;

  Future<void> collectFormData() async{
    // Collect selected job preferences as comma-separated values
    String selectedPreferences = prefsChecked.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(", ");

    // Collect selected job types (tags) as comma-separated values
    String selectedTags = _tags
        .where((tag) => tag["selected"] == true)
        .map((tag) => tag["name"] as String)
        .join(", ");

    // Collect selected locations as comma-separated values
    String selectedLocations = _locations
        .where((location) => location["selected"] == true)
        .map((location) => location["name"] as String)
        .join(", ");
        
    Map<String, dynamic> updateData = {
    'job_preferences': selectedPreferences,
    'job_type_preferences': selectedTags,
    'job_location_preferences': selectedLocations,
    };
    String whereClause = 'id = ?';
    List<dynamic> whereArgs = [widget.id];

    bool success = await jobseekerRepo.update(updateData, whereClause, whereArgs);
    Map<String, dynamic>? jobseeker = await jobseekerRepo.getById(widget.id);

    if (success || jobseeker != null) {
      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobseekerHome(id: widget.id)));
      AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Hello ${jobseeker!["full_name"]}!',
                body: 'You can now fill your profile with your details.',
                notificationLayout: NotificationLayout.Default,
              ),
            );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add jobseeker preferences')),
      );
    }
  }


  Widget buildTile(Icon icon, String str) {
    return GestureDetector(
      onTap: () {
        setState(() {
          prefsChecked[str] = !(prefsChecked[str] ?? false);
          if (str == "Others") {
            _others = !_others;
          }
        });
      },
      child: Container(
        width: AppSizes.getScreenWidth(context) * 0.5,
        height: AppSizes.getScreenHeight(context) * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: AppSizes.getScreenWidth(context) * 0.07),
                icon,
                SizedBox(width: AppSizes.getScreenWidth(context) * 0.04),
                Text(str, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: prefsChecked[str] ?? false
                      ? AppColors.lightGreenColor
                      : Colors.transparent,
                ),
                child: prefsChecked[str] ?? false
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        actions: const [
          KhotwaLogo(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSizes.getScreenHeight(context) * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What are the jobs you are looking for?",
                      style: TextStyle(
                        fontFamily: AppFonts.secondaryFont,
                        color: AppColors.blueButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _prefsMap.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: buildTile(entry.key, entry.value),
                      );
                    }).toList(),
                  ),
                ),
                if (_others)
                  Container(
                    width: AppSizes.getScreenWidth(context) * 0.8,
                    height: AppSizes.getScreenHeight(context) * 0.06,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.getScreenWidth(context) * 0.07,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your text here',
                        hintText: 'Type something...',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                SizedBox(
                  height: AppSizes.getScreenHeight(context) * 0.04,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Job Preferences",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    color: AppColors.blueButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.02,
            ),
            Container(
              height: AppSizes.getScreenHeight(context) * 0.002,
              width: AppSizes.getScreenWidth(context) * 0.9,
              color: const Color.fromARGB(111, 158, 158, 158),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Types",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    color: AppColors.blueButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                ..._getVisibleTags().map((tag) {
                  return RawChip(
                    label: Text(tag["name"]),
                    selected: tag["selected"],
                    onSelected: (bool selected) {
                      setState(() {
                        tag["selected"] = selected;
                      });
                    },
                    selectedColor: AppColors.blueButtonColor,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: tag["selected"] ? Colors.white : Colors.black,
                    ),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  );
                }),
                if (!_showAllTags)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllTags = true;
                        });
                      },
                      child: const Text(
                        "See all...",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.02,
            ),
            Container(
              height: AppSizes.getScreenHeight(context) * 0.002,
              width: AppSizes.getScreenWidth(context) * 0.9,
              color: const Color.fromARGB(111, 158, 158, 158),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Locations",
                  style: TextStyle(
                    fontFamily: AppFonts.secondaryFont,
                    color: AppColors.blueButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                ..._getVisibleLocations().map((location) {
                  return RawChip(
                    label: Text(location["name"]),
                    selected: location["selected"],
                    onSelected: (bool selected) {
                      setState(() {
                        location["selected"] = selected;
                      });
                    },
                    selectedColor: AppColors.blueButtonColor,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: location["selected"] ? Colors.white : Colors.black,
                    ),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  );
                }),
                if (!_showAllLocations)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllLocations = true;
                        });
                      },
                      child: const Text(
                        "See all...",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.04,
            ),
            SizedBox(
              width: 266,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  collectFormData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGreenColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.08,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getVisibleTags() {
    if (_showAllTags) {
      return _tags;
    } else {
      return _tags.take(5).toList();
    }
  }

  List<Map<String, dynamic>> _getVisibleLocations() {
    if (_showAllLocations) {
      return _locations;
    } else {
      return _locations.take(5).toList();
    }
  }
}
