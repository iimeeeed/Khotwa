import 'package:flutter/material.dart';
import 'package:khotwa/screens/company/company_home.dart';
import '../../commons/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import '../../backend/models/company.dart';
import '../../backend/repository/companies_repository.dart';
import 'dart:convert';

class CompanyVerificationPage extends StatefulWidget {
  final Map<String, dynamic> companyData ;
  const CompanyVerificationPage({super.key, required this.companyData});

  @override
  _CompanyVerificationPageState createState() =>
      _CompanyVerificationPageState();
}

class _CompanyVerificationPageState extends State<CompanyVerificationPage> {
  int currentStep = 0;
  bool isSelected = false;
  File? _selectedLogo;
  Uint8List? _logoBytes;
  final PageController _pageController = PageController();
  final CompaniesRepository _companiesRepository = CompaniesRepository(); 
  final GlobalKey<FormState> _step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step4FormKey = GlobalKey<FormState>();

  // Controllers for TextFields
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController industryController = TextEditingController();
  final TextEditingController companySizeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController companyDescriptionController = TextEditingController();
  final TextEditingController tradeRegisterController = TextEditingController();
  final TextEditingController taxIdentificationController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    companyNameController.dispose();
    industryController.dispose();
    companySizeController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    websiteController.dispose();
    companyDescriptionController.dispose();
    tradeRegisterController.dispose();
    taxIdentificationController.dispose();
    super.dispose();
  }

  Future<void> _uploadLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      _logoBytes = await file.readAsBytes(); // Read image as bytes
      setState(() {
        _selectedLogo = file;
      });
    }
  }

  // Function to save company data into the database
  Future<void> saveCompanyData() async {
    String? base64Logo = _logoBytes != null ? base64Encode(_logoBytes!) : null;

    Company company = Company(
      companyOwnerName: widget.companyData['ownerName'],
      companyUserEmail:widget.companyData['email'],
      companyUserPassword: widget.companyData['password'],
      companyName: companyNameController.text,
      companyIndustry: industryController.text,
      companySize: companySizeController.text.isEmpty ? null : companySizeController.text,
      companyLocation: locationController.text.isEmpty ? null : locationController.text,
      companyEmail: emailController.text,
      companyPhone: phoneController.text.isEmpty ? null : phoneController.text,
      companyWebsite: websiteController.text.isEmpty ? null : websiteController.text,
      companyLogo: base64Logo, // Save Base64 string
      companyDescription: companyDescriptionController.text,
      tradeRegisterNumber: tradeRegisterController.text,
      taxIdentificationNumber: taxIdentificationController.text,
      createdAt: '10-10-2004', // for testing
    );

    bool success = await _companiesRepository.insert(company);
    int? companyId = await _companiesRepository.getIdByEmail(widget.companyData['email']);
    if (success && companyId!=null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyHome(id: companyId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save company data')),
      );
    }
  }

  // Field validators
  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^(06|05|07)\d{8}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  bool handleStepValidation() {
  switch (currentStep) {
    case 0:
      if (!_step1FormKey.currentState!.validate()) return false;
      break;
    case 1:
      if (!_step2FormKey.currentState!.validate()) return false;
      break;
    case 2:
      if (!_step3FormKey.currentState!.validate()) return false;
      break;
    case 3:
      if (!_step4FormKey.currentState!.validate()) return false;
      break;
  }
  return true;
}

  Widget _buildInputField(String label, String hint,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      double height = 90,
      double width = 120}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFB0B0B0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment:
                  (label == "Logo") ? Alignment.center : Alignment.centerLeft,
              child: label == "Logo"
                  ? GestureDetector(
                      onTap: _uploadLogo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_selectedLogo != null) 
                            Image.file(
                              _selectedLogo!,
                              height: 100,
                            )
                          else 
                            const Column(
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  color: Color.fromARGB(255, 216, 219, 218),
                                  size: 24,
                                ),
                                SizedBox(height: 12),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Drop here to attach or ',
                                        style: TextStyle(
                                          color: Color(0xFFD5D9D8),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'upload',
                                        style: TextStyle(
                                          color: Color(0xFF93C5FD),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Max size: 5MB',
                                  style: TextStyle(
                                    color: Color(0xFFD5D9D8),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  :TextFormField(
                        validator: validator,
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: const TextStyle(
                            color: Color(0xFFD5D9D8),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          prefixText: label == "Website" ? "https://" : null,
                          prefixStyle: const TextStyle(
                            color: AppColors.blueButtonColor,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: AppColors.blueButtonColor,
                  ),
            ),
            Positioned(
              top: -12,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), 
                decoration: ShapeDecoration(
                  color: AppColors.primaryBackgroundColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFCDD0CF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.blueButtonColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getProgressIndicator(String step) {
    return Positioned(
      left: 0,
      top: -20,
      child: Text(
        step,
        style: const TextStyle(
          color: AppColors.lightGreenColor,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget getProgressIcon(bool isLast) {
    return Positioned(
      left: isLast ? 60 : 15,
      top: -26,
      child: Image.asset(
        "assets/man.png",
        height: 40,
      ),
    );
  }

  Widget _buildProgressSegment({bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 7,
        decoration: ShapeDecoration(
          color: isActive ? AppColors.lightGreenColor : AppColors.primaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 0),
              (currentStep == 0)
                  ? getProgressIndicator('Basic Information')
                  : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 1),
              (currentStep == 1)
                  ? getProgressIndicator('Contact Details')
                  : (currentStep == 0)
                      ? getProgressIcon(false)
                      : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 2),
              (currentStep == 2)
                  ? getProgressIndicator('Company Profile')
                  : (currentStep == 1)
                      ? getProgressIcon(false)
                      : Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildProgressSegment(isActive: currentStep >= 3),
              if (currentStep == 3) ...[
                getProgressIndicator('Identification'),
                getProgressIcon(true),
              ] else if (currentStep == 2) ...[
                getProgressIcon(false),
              ] else
                Container(),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Khotwa",
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
                      fontFamily: "Khmer MN",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Company Verification',
                    style: TextStyle(
                      color: AppColors.blueButtonColor,
                      fontSize: 20,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildProgressIndicator(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: AppSizes.getScreenHeight(context),
                decoration: const BoxDecoration(
                  color:AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSizes.getScreenHeight(context) * 0.65,
                      child: Column(
                        children: [
                          if (currentStep == 0) ...[
                            const Center(
                              child: Text(
                                'Fill your Company Details',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Form(
                              key: _step1FormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  _buildInputField(
                                      'Company Name', 'Your Company Name', controller:companyNameController, validator: (value) => _validateField(value, 'Company Name'),),
                                  const SizedBox(height: 30),
                                  _buildInputField(
                                      'Industry', 'Select your Industry', controller: industryController, validator: (value) => _validateField(value, 'Industry'),),
                                  const SizedBox(height: 30),
                                  _buildInputField(
                                      'Company Size', 'Select your Company Size', controller: companySizeController, validator: (value) => _validateField(value, 'Company Size'),),
                                  const SizedBox(height: 20),
                                ], 
                              ),
                            )
                          ] else if (currentStep == 1) ...[
                            const Center(
                              child: Text(
                                'Enter your contact infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Form(
                              key: _step2FormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  _buildInputField('Email Address', 'Email', controller: emailController, validator: (value) => _validateEmail(value),),
                                  const SizedBox(height: 30),
                                  _buildInputField('Phone Number', 'Phone Number', controller: phoneController, validator: (value) => _validatePhone(value)),
                                  const SizedBox(height: 30),
                                  _buildInputField('Location', 'Your Exact Address', controller: locationController, validator: (value) => _validateField(value, 'Location'),),
                                    const SizedBox(height: 20),
                                ]
                              )
                            )
                          ] else if (currentStep == 2) ...[
                            const Center(
                              child: Text(
                                'Enter your Profile infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Form(
                              key: _step3FormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  _buildInputField(
                                      'Website', "Your company's website link", controller: websiteController, validator: (value) => _validateField(value, 'website'),),
                                  const SizedBox(height: 30),
                                  _buildInputField(
                                      'Logo', 'Drop here to attach or upload',
                                      height: 150),
                                  const SizedBox(height: 30),
                                  _buildInputField('Company Description',
                                      "Briefly describe your company's mission, vision, and services", controller: companyDescriptionController, validator: (value) => _validateField(value, 'Company Description'),
                                      height: 130),
                                  const SizedBox(height: 30),
                                ]
                              )
                            )
                          ] else if (currentStep == 3) ...[
                            const Center(
                              child: Text(
                                'Enter your Identification infos',
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Form(
                              key: _step4FormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  _buildInputField('Trade Register Number (RC)',
                                      "`Registre de Commerce` number", controller: tradeRegisterController, validator: (value) => _validateField(value, 'RC')), 
                                  const SizedBox(height: 30),
                                  _buildInputField('Tax Identification Number (NIF)',
                                      "`Numéro d'Identification Fiscale`", controller: taxIdentificationController, validator: (value) => _validateField(value, 'NIF')),
                                  const SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isSelected = !isSelected;
                                          });
                                        },
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: ShapeDecoration(
                                            color: isSelected
                                                ? AppColors.lightGreenColor
                                                : Colors.white,
                                            shape: const OvalBorder(
                                              side: BorderSide(
                                                width: 0.5,
                                                color: AppColors.blueButtonColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              height: 1.5,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'I confirm I represent HR/Personnel, Recruiting, Marketing, PR, or am an executive at my company and I agree to Khotwa\'s '),
                                              TextSpan(
                                                text: 'Terms of Use',
                                                style: TextStyle(
                                                    color: Color(0xFF6EA5ED)),
                                              ),
                                              TextSpan(text: ' and acknowledge its '),
                                              TextSpan(
                                                text: 'privacy policy',
                                                style: TextStyle(
                                                    color: Color(0xFF6EA5ED)),
                                              ),
                                              TextSpan(
                                                  text: ' on behalf of my company.'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ]
                              )
                            )
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (currentStep > 0) {
                              setState(() {
                                currentStep--;
                              });
                              _pageController.animateToPage(currentStep,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:AppColors.primaryBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(83, 30),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Color(0xFF95969D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if(handleStepValidation())
                            {
                              if (currentStep < 3) {
                                setState(() {
                                  currentStep++;
                                });
                                _pageController.animateToPage(currentStep,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              } else {
                                saveCompanyData();
                                
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (currentStep == 3)
                                ? AppColors.blueButtonColor
                                : AppColors.lightGreenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(83, 30),
                          ),
                          child: Text(
                            (currentStep == 3) ? "Let's Go" : 'Next',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
