import 'package:flutter/material.dart';
import '../../commons/constants.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  RangeValues _currentRangeValues = const RangeValues(40000, 90000);
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
                    // Handle post action
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
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width / 2 - 17.5,
            child: Container(
              height: 4,
              width: 35,
              decoration: ShapeDecoration(
                color: AppColors.greyTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
            hint: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFFAFB0B6),
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            items: const [
              DropdownMenuItem(value: "Option 1", child: Text("Option 1")),
              DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
            ],
            onChanged: (value) {
              // Handle dropdown change
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
