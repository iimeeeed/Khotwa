import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import 'package:khotwa/widgets/bottom_sheet.dart';

class SearchFilterBar extends StatefulWidget {
  final String hint;
  final Function(String) onSearch;
  final Widget filterScreen;
  final bool isCompany;

  const SearchFilterBar({
    super.key,
    this.hint = 'Search...',
    required this.onSearch,
    required this.isCompany,
    Widget? filterScreen,
    required Null Function() onFilterTap,
  }) : filterScreen = filterScreen ?? const DefaultFilterScreen();

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSizes.getScreenHeight(context) * 0.06,
            child: TextField(
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.blueButtonColor),
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Color(0xFFAFB0B6),
                  fontSize: 14,
                  fontFamily: 'popppins',
                  fontWeight: FontWeight.w400,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                focusColor: Colors.transparent,
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (!widget.isCompany)
          GestureDetector(
            onTap: () {
              BottomDialog.show(
                  context,
                  widget
                      .filterScreen); // Show the filter screen in a bottom sheet
            },
            child: Container(
              height: AppSizes.getScreenHeight(context) * 0.06,
              width: AppSizes.getScreenWidth(context) * 0.12,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Image(image: AssetImage("assets/filter.png")),
            ),
          ),
      ],
    );
  }
}

// Default filter screen widget (can be customized)
class DefaultFilterScreen extends StatelessWidget {
  const DefaultFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No filters available',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
