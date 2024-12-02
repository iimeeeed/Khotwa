import 'package:flutter/material.dart';

class BottomDialog {
  static void show(BuildContext context, Widget inputWidget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          minChildSize: 0.9,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return inputWidget;
          },
        );
      },
    );
  }
}
