import 'package:flutter/material.dart';
import 'package:khotwa/screens/company/company_home.dart';
import '../../commons/constants.dart';
import '../../backend/models/job.dart';
import '../../backend/repository/jobs_repository.dart';

class CreatePost extends StatefulWidget {
  final int id;
  const CreatePost({super.key, required this.id});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  int currentStep = 0;
  bool isSelected = false;
  final JobsRepository _jobRepository = JobsRepository();
  RangeValues _currentRangeValues = const RangeValues(40000, 90000);

  final Map<String, List<String>> dropdownOptions = {
    "Job category": [
      "Design",
      "Administration",
      "Human Resources",
      "Marketing"
    ],
    "Job subcategory": ["3d Design", "UI/UX", "Photoshop"],
    "Location": ["Algiers", "Medea", "Blida", "Oran", "Oum El Bouaghi"],
    "Job Type": ["Full-Time", "Part-Time", "Internship", "Remote"],
  };

  final Map<String, String?> selectedItems = {};

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController facilitiesController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    addressController.dispose();
    facilitiesController.dispose();
    responsibilitiesController.dispose();
    requirementsController.dispose();
    super.dispose();
  }

  // Function to save job post data
  Future<void> saveJobPost() async {
    Job jobpost = Job(
      companyId: widget.id, 
      jobTitle: jobTitleController.text,
      jobDescription: jobDescriptionController.text,
      jobCategory: selectedItems["Job category"],
      jobSubCategory: selectedItems["Job subcategory"],
      jobLocation: selectedItems["Location"]!, 
      jobAddress: addressController.text,
      jobType: selectedItems["Job Type"],
      salaryLowerBound: _currentRangeValues.start,
      salaryUpperBound: _currentRangeValues.end,
      jobFacilities: facilitiesController.text,
      jobResponsibilities: responsibilitiesController.text, 
      requirements: requirementsController.text, 
      createdAt: DateTime.now().toString(),
    );
    bool success = await _jobRepository.insert(jobpost); 
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyHome(id: widget.id),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save job post')),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                buildInputField("Job Title", "eg: Business Analyst"),
                const SizedBox(height: 16),
                buildInputField("Job Description", "eg: Our company offers...",
                    maxLines: 4),
                const SizedBox(height: 16),
                buildDropdownField("Job category", "eg: UI/UX Design"),
                const SizedBox(height: 16),
                buildDropdownField("Job subcategory", "eg: Graphics Design"),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: buildDropdownField("Location", "Algiers"),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: buildInputField("Address", "eg: Mahelma, Zeralda"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                buildDropdownField("Job Type", "Select Job Type"),
                const SizedBox(height: 16),
                buildPriceAdjuster(
                    currentRangeValues: _currentRangeValues,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    }),
                const SizedBox(height: 16),
                buildInputField(
                    "Facilities", "eg: healthcare, paid time off,..."),
                const SizedBox(height: 16),
                buildInputField("Responsibilities", "•\n•\n•\n....",
                    maxLines: 4),
                const SizedBox(height: 16),
                buildInputField("Requirements", "•\n•\n•\n....", maxLines: 4),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    saveJobPost();
                    print('worked');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blueButtonColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFAFB0B6),
              fontSize: 14,
              fontFamily: 'popppins',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blueButtonColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            underline: Container(),
            isExpanded: true,
            value: selectedItems[label],
            hint: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFFAFB0B6),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            items: dropdownOptions[label]
                ?.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedItems[label] = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildPriceAdjuster({
    required RangeValues currentRangeValues,
    required Function(RangeValues) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Adjust Salary Range",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blueButtonColor,
          ),
        ),
        const SizedBox(height: 20),
        RangeSlider(
          values: currentRangeValues,
          min: 0,
          max: 100000,
          divisions: 20,
          labels: RangeLabels(
            "${currentRangeValues.start.toStringAsFixed(0)} DZ",
            "${currentRangeValues.end.toStringAsFixed(0)} DZ",
          ),
          activeColor: AppColors.blueButtonColor,
          onChanged: onChanged,
        ),
        const SizedBox(height: 20),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText:
                "Salary Range: ${currentRangeValues.start.toStringAsFixed(0)} DZ - ${currentRangeValues.end.toStringAsFixed(0)} DZ",
            hintStyle: const TextStyle(
              color: AppColors.greyTextColor,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
