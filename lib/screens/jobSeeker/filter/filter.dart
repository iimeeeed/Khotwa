import 'package:flutter/material.dart';
import '../../../commons/constants.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final List<String> _jobTypes = [
    'All types',
    'Full-time',
    'Part-time',
    'Freelance',
    'Internship',
    'Contract',
    'Temporary'
  ];
  bool _showAllJobTypes = false;
  final List<int> _selectedTypes = [];

  final List<String> _categories = [
    'Design',
    'Marketing',
    'Human resources',
    'Administration'
  ];
  String? _selectedCategory;

  final List<String> _subcategories = [
    'UI/UX Design',
    'SEO Marketing',
    'HR Training',
    'Office Admin'
  ];
  String? _selectedSubCategory;

  final List<String> _locations = [
    'New York',
    'San Francisco',
    'London',
    'Tokyo'
  ];
  String? _selectedLocation;

  final List<String> _levels = [
    'Entry',
    'Junior',
    'Senior',
  ];
  String? _selectedLevels;

  RangeValues _salaryRange = const RangeValues(30000.0, 1000000.0);

  final int _visibleJobTypesCount = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.getScreenWidth(context) * 0.1,
            vertical: AppSizes.getScreenHeight(context) * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(
                context: context,
                label: "Category",
                hint: "Select a category",
                value: _selectedCategory,
                items: _categories,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                context: context,
                label: "Subcategory",
                hint: "Select a subcategory",
                value: _selectedSubCategory,
                items: _subcategories,
                onChanged: (value) {
                  setState(() {
                    _selectedSubCategory = value;
                  });
                },
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
              Center(
                child: Container(
                  color: const Color.fromARGB(40, 78, 75, 75),
                  height: 3,
                  width: AppSizes.getScreenWidth(context) * 0.78,
                ),
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
              _buildDropdown(
                context: context,
                label: "Location",
                hint: "Select a location",
                value: _selectedLocation,
                items: _locations,
                leadingIcon: Icons.place_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
              _buildDropdown(
                context: context,
                label: "Experience Level",
                hint: "Select your level",
                value: _selectedLevels,
                items: _levels,
                leadingIcon: Icons.cases_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedLevels = value;
                  });
                },
              ),
              SizedBox(
                height: AppSizes.getScreenHeight(context) * 0.03,
              ),
              Center(
                child: Container(
                  color: const Color.fromARGB(40, 78, 75, 75),
                  height: 3,
                  width: AppSizes.getScreenWidth(context) * 0.78,
                ),
              ),
              SizedBox(
                height: AppSizes.getScreenHeight(context) * 0.03,
              ),
              const Text(
                "Salary Range",
                style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 18,
                  color: AppColors.blueButtonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: AppSizes.getScreenHeight(context) * 0.01,
              ),
              Text(
                "Selected range: ${_salaryRange.start.round()} DA - ${_salaryRange.end.round()} DA",
                style: const TextStyle(color: Colors.grey),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RangeSlider(
                    activeColor: AppColors.blueButtonColor,
                    values: _salaryRange,
                    min: 30000.0, // Updated minimum value
                    max: 1000000.0, // Updated maximum value
                    labels: RangeLabels(
                      "${_salaryRange.start.round()} DA",
                      "${_salaryRange.end.round()} DA",
                    ),
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        _salaryRange = newRange;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
              Center(
                child: Container(
                  color: const Color.fromARGB(40, 78, 75, 75),
                  height: 3,
                  width: AppSizes.getScreenWidth(context) * 0.78,
                ),
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.03),
              const Text(
                "Job Types",
                style: TextStyle(
                  fontFamily: AppFonts.secondaryFont,
                  fontSize: 18,
                  color: AppColors.blueButtonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.getScreenHeight(context) * 0.02),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  ..._jobTypes
                      .take(_showAllJobTypes
                          ? _jobTypes.length
                          : _visibleJobTypesCount)
                      .map((jobType) {
                    int index = _jobTypes.indexOf(jobType);
                    return RawChip(
                      label: Text(jobType),
                      selected: _selectedTypes.contains(index),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedTypes.add(index);
                          } else {
                            _selectedTypes.remove(index);
                          }
                        });
                      },
                      selectedColor: AppColors.blueButtonColor,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: _selectedTypes.contains(index)
                            ? Colors.white
                            : Colors.black,
                      ),
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.transparent),
                      ),
                    );
                  }),
                  if (_jobTypes.length > _visibleJobTypesCount)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showAllJobTypes = !_showAllJobTypes;
                          });
                        },
                        child: Text(
                          _showAllJobTypes ? "Show less" : "See all...",
                          style: const TextStyle(
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
              Center(
                child: SizedBox(
                  width: 266,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGreenColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15),
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
              ),
              SizedBox(
                height: AppSizes.getScreenHeight(context) * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    IconData? leadingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.secondaryFont,
            fontSize: 18,
            color: AppColors.blueButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: AppSizes.getScreenHeight(context) * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(40, 78, 75, 75),
              width: 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              value: value,
              hint: Text(hint),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    color: Colors.white, // Set the item background color
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        if (leadingIcon != null) Icon(leadingIcon, size: 20),
                        if (leadingIcon != null) const SizedBox(width: 8),
                        Text(value),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
