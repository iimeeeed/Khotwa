import 'package:flutter/material.dart';
import '../../commons/constants.dart';

class PlanInterview extends StatefulWidget {
  const PlanInterview({super.key});

  @override
  State<PlanInterview> createState() => _PlanInterviewState();
}

class _PlanInterviewState extends State<PlanInterview> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String startPeriod = "AM";
  String endPeriod = "AM";
  String selectedType = 'Remote';

  // Function to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            buildInputField("Title", "Interview Title"),
            const SizedBox(height: 16),
            buildInputField("Description", "The interview process or details", maxLines: 4),
            const SizedBox(height: 16),
            dateSelector(context),
            const SizedBox(height: 16),
            timeRangeSelector(context),
            const SizedBox(height: 16),
            typeSelector(),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  width: AppSizes.getScreenWidth(context) * 0.6,
                  height: AppSizes.getScreenHeight(context) * 0.08,
                  decoration: ShapeDecoration(
                    color: AppColors.lightGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Center(
                    child: Text(
                      'Plan ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'poppin',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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

  Widget timeRangeSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time :',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blueButtonColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Start Time Selector
            _timeSelector(
              context,
              label: "Start",
              selectedTime: startTime,
              selectedPeriod: startPeriod,
              onTimeSelected: (time, period) {
                setState(() {
                  startTime = time;
                  startPeriod = period;
                });
              },
            ),
            // End Time Selector
            _timeSelector(
              context,
              label: "End",
              selectedTime: endTime,
              selectedPeriod: endPeriod,
              onTimeSelected: (time, period) {
                setState(() {
                  endTime = time;
                  endPeriod = period;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _timeSelector(
    BuildContext context, {
    required String label,
    required TimeOfDay? selectedTime,
    required String selectedPeriod,
    required Function(TimeOfDay, String) onTimeSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    primaryColor: AppColors.lightGreenColor,
                    buttonTheme: const ButtonThemeData(
                      buttonColor: AppColors.lightGreenColor,
                      textTheme: ButtonTextTheme.primary,
                    ),
                    timePickerTheme: const TimePickerThemeData(
                      dialTextColor: AppColors.blueButtonColor,
                      dialHandColor: AppColors.lightGreenColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedTime != null) {
              onTimeSelected(pickedTime, selectedPeriod);
            }
          },
          child: Row(
            children: [
              _timeBox(selectedTime?.hourOfPeriod.toString().padLeft(2, '0') ??
                  'HH'),
              _colon(),
              _timeBox(selectedTime?.minute.toString().padLeft(2, '0') ?? 'MM'),
              const SizedBox(width: 10),
              _dropdownPeriodSelector(
                selectedPeriod,
                (newPeriod) {
                  if (newPeriod != null) {
                    onTimeSelected(selectedTime ?? TimeOfDay.now(), newPeriod);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _timeBox(String value) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGreenColor,
            width: 2.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: AppColors.blueButtonColor,
        ),
      ),
    );
  }

  Widget _colon() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blueButtonColor,
        ),
      ),
    );
  }

  Widget _dropdownPeriodSelector(
      String currentValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      underline: Container(),
      items: const [
        DropdownMenuItem(value: "AM", child: Text("AM")),
        DropdownMenuItem(value: "PM", child: Text("PM")),
      ],
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Poppins',
        color: AppColors.blueButtonColor,
      ),
    );
  }

  Widget dateSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blueButtonColor,
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              selectedDate != null
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : "DD/MM/YY",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.blueButtonColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget typeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Type : ",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blueButtonColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'Remote';
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: selectedType == 'Remote'
                      ? AppColors.blueButtonColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Remote",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selectedType == 'Remote'
                        ? Colors.white
                        : AppColors.blueButtonColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'in-person';
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: selectedType == 'in-person'
                      ? AppColors.blueButtonColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "In-person",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selectedType == 'in-person'
                        ? Colors.white
                        : AppColors.blueButtonColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
