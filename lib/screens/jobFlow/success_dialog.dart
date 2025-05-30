import 'package:flutter/material.dart';
import 'package:khotwa/screens/jobSeeker/homePage.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onTrackApplication;

  const SuccessDialog({
    super.key,
    required this.onClose,
    required this.onTrackApplication,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/asset2.png',  
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 24),
            const Text(
              'Apply Success',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002D62),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your job apply successfully applied, wait\nfor the company to accept and follow\nback to you',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const JobseekerHome(id: 1,),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002D62),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onTrackApplication,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF002D62)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Track Application',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF002D62),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}