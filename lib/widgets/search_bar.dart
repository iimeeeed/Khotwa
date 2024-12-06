import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
class SearchFilterBar extends StatefulWidget {
  final String hint;
  final Function(String) onSearch;

  const SearchFilterBar({
    super.key,
    this.hint = 'Search...',
    this.onSearch = _defaultOnSearch, // Assign a default function
  });

  static void _defaultOnSearch(String value) {
    // Navigate to the CompanyHome screen or perform a default action
    print("Default search action for value: $value");
    // Example: Add navigation logic here if needed
    // Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyHome()));
  }

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
                prefixIcon: const Icon(Icons.search, color: AppColors.blueButtonColor),
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
        Container(
          height: AppSizes.getScreenHeight(context) * 0.06,
          width: AppSizes.getScreenWidth(context) * 0.12,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Image(image: AssetImage("assets/filter.png")),
        ),
      ],
    );
  }
}
