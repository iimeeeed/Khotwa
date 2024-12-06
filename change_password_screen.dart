import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF3F2), // Light background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),

            // Old Password Field
            _buildPasswordField(
              label: 'Old Password',
              isPasswordVisible: oldPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  oldPasswordVisible = !oldPasswordVisible;
                });
              },
            ),
            SizedBox(height: 20),

            // New Password Field
            _buildPasswordField(
              label: 'New Password',
              isPasswordVisible: newPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  newPasswordVisible = !newPasswordVisible;
                });
              },
            ),
            SizedBox(height: 20),

            // Confirm Password Field
            _buildPasswordField(
              label: 'Confirm Password',
              isPasswordVisible: confirmPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  confirmPasswordVisible = !confirmPasswordVisible;
                });
              },
            ),
            SizedBox(height: 140),

            // Change Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle change password logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF002B5C), // Dark blue color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool isPasswordVisible,
    required VoidCallback togglePasswordVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent), // Transparent border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent), // Transparent border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent), // Transparent border
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
