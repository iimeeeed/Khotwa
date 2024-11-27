import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackgroundColor = Color(0xFFEFF3F2);
  static const Color greyTextColor = Color(0xFF95969D);
  static const Color blackTextColor = Color(0xFF0D0D26);
  static const Color redTextColor = Color(0xFFFD484D);
  static const Color greenTextColor = Color(0xFF009432);
  static const Color blueButtonColor = Color(0xFF1B4174);
  static const Color lightGreenColor = Color(0xFF84BDA9);
  static const Color secondaryButtonColor = Color(0xFFFFEFCB);
  static const Color secondaryLinkColor = Color(0xFFFF9228);
}

class AppFonts {
  static const String primaryFont = 'Khmer MN';
  static const String secondaryFont = 'DM Sans';
  static const String secondaryFontItalic = 'DM Sans Italic';
}

class AppInputStyles {
  static InputDecoration inputDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontFamily: AppFonts.secondaryFont,
        color: Colors.grey,
        fontSize: 15,
      ),
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class AppSizes {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
