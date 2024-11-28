import 'package:flutter/material.dart';
import '../../../commons/constants.dart';
import '../../../commons/khotwa_logo.dart';

class Prefs extends StatefulWidget {
  const Prefs({super.key});

  @override
  State<Prefs> createState() => _PrefsState();
}

class _PrefsState extends State<Prefs> {
  Map<Icon, String> _prefsMap = {
    Icon(Icons.design_services): "Designer",
    Icon(Icons.developer_mode): "Developer",
    Icon(Icons.admin_panel_settings_sharp): "Administrative",
    Icon(Icons.sell): "Marketing",
    Icon(Icons.manage_accounts): "Management",
    Icon(Icons.other_houses): "Others",
  };

  final List<Map<String, dynamic>> _tags = [
    {"name": "Product Designer", "selected": false},
    {"name": "Business Analyst", "selected": false},
    {"name": "UX Designer", "selected": false},
    {"name": "Graphics Designer", "selected": false},
    {"name": "Developer", "selected": false},
    {"name": "Engineer", "selected": false},
    {"name": "Architect", "selected": false}, // Fixed duplicate
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

  Widget buildTile(Icon icon, String str) {
    return Container(
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
              Text(str),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Transform.scale(
              scale: 1.1,
              child: Checkbox(
                side: BorderSide(color: Colors.grey, width: 1.0),
                value: prefsChecked[str] ?? false,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: const CircleBorder(),
                activeColor: Color(0xFF84BDA9),
                onChanged: (bool? value) {
                  setState(() {
                    prefsChecked[str] = value ?? false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, bool> prefsChecked = {};

  @override
  void initState() {
    super.initState();
    prefsChecked = {for (var entry in _prefsMap.values) entry: false};
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What type of job you are looking for?",
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
                    physics: NeverScrollableScrollPhysics(),
                    children: _prefsMap.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: buildTile(entry.key, entry.value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Roles",
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
                      side: BorderSide(color: Colors.transparent),
                    ),
                  );
                }).toList(),
                if (!_showAllTags)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllTags = true;
                        });
                      },
                      child: Text(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      side: BorderSide(color: Colors.transparent),
                    ),
                  );
                }).toList(),
                if (!_showAllLocations)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllLocations = true;
                        });
                      },
                      child: Text(
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
                onPressed: () {},
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
