import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khotwa/backend/repository/companies_repository.dart';
import 'package:khotwa/backend/repository/job_seekers_repository.dart';
import 'package:khotwa/commons/constants.dart';
import '../data/profile_data.dart';
import 'package:khotwa/screens/company/settings/main_settings.dart';

class Profile extends StatefulWidget {
  final int id;
  final bool isCompany;

  const Profile({super.key, required this.isCompany, required this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  final TextEditingController jobSeekerNameController = TextEditingController();
  final TextEditingController jobSeekerEmailController = TextEditingController();
  final TextEditingController jobSeekerPhoneController = TextEditingController();
  final TextEditingController jobSeekerLocationController = TextEditingController();
  final TextEditingController jobSeekerDescriptionController = TextEditingController();
  final TextEditingController jobSeekerExperienceController = TextEditingController();
  final TextEditingController jobSeekerEducationController = TextEditingController();
  final TextEditingController jobSeekerSkillsController = TextEditingController();
  final TextEditingController jobSeekerLanguagesController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    companyNameController.dispose();
    industryController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    websiteController.dispose();
    companyDescriptionController.dispose();
    tradeRegisterController.dispose();
    taxIdentificationController.dispose();
    jobSeekerNameController.dispose();
    jobSeekerEmailController.dispose();
    jobSeekerPhoneController.dispose();
    jobSeekerLocationController.dispose();
    jobSeekerDescriptionController.dispose();
    jobSeekerExperienceController.dispose();
    jobSeekerEducationController.dispose();
    jobSeekerSkillsController.dispose();
    jobSeekerLanguagesController.dispose();
    super.dispose();
  }
  
  final JobSeekersRepository _jobSeekersRepository = JobSeekersRepository();
  final CompaniesRepository _companiesRepository = CompaniesRepository();
  late Map _user ;

  File? _profilePic;
  Uint8List? _picBytes;
  bool _isEditingPic = false;
  late List<bool> _isEditingMap ; 

  bool _isEditingTile(int index) => _isEditingMap[index];

  void _toggleEditingTile(int index) {
    setState(() {
      _isEditingMap[index] = !_isEditingTile(index);
    });
  }

  Future<void> _uploadPic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      _picBytes = await file.readAsBytes(); // Read image as bytes
      setState(() {
        _profilePic = file;
      });
    }
  }

  Future<void> saveProfilePic() async {
    String? base64Logo = _picBytes != null ? base64Encode(_picBytes!) : null;
    String whereClause = 'id = ?';
    List<dynamic> whereArgs = [widget.id];
    Map<String, dynamic> updateData = widget.isCompany
        ? {'company_logo': base64Logo}
        : {'profile_picture': base64Logo};

    bool success = widget.isCompany
        ? await _companiesRepository.update(updateData, whereClause, whereArgs)
        : await _jobSeekersRepository.update(updateData, whereClause, whereArgs);

    if (success) {
      setState(() {
        _user[widget.isCompany ? 'company_logo' : 'profile_picture'] = base64Logo;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile picture')),
      );
    }
  }

  Future<void> saveChange(int index) async {
    String whereClause = 'id = ?';
    List<dynamic> whereArgs = [widget.id];
    Map<String, dynamic> updateData = widget.isCompany
        ? {companyInfo[index]['column'] : companyInfo[index]['controller'].text}
        : {jobseekerInfo[index]['column'] : jobseekerInfo[index]['controller'].text};

    bool success = widget.isCompany
        ? await _companiesRepository.update(updateData, whereClause, whereArgs)
        : await _jobSeekersRepository.update(updateData, whereClause, whereArgs);

    if (success) {
      setState(() {
        if(widget.isCompany )
        {
          _user[companyInfo[index]['column']] = companyInfo[index]['controller'].text;
          companyInfo[index]['content'] = companyInfo[index]['controller'].text;
        }
        else
        {
          _user[jobseekerInfo[index]['column']] = jobseekerInfo[index]['controller'].text;
          jobseekerInfo[index]['content'] = jobseekerInfo[index]['controller'].text;
        }
        
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update ${widget.isCompany ? companyInfo[index]['label'] : jobseekerInfo[index]['label']}')),
      );
    }
  }

  // Fetch the user data based on the id
  Future<void> _fetchUserData() async {
    final user = (widget.isCompany)? await _companiesRepository.getById(widget.id) : await _jobSeekersRepository.getById(widget.id);
    if (user != null) {
      setState(() {
        _user = user;
        if(widget.isCompany)
        {
          companyNameController.text = companyInfo[0]['content'] = user['company_name'];
          emailController.text = companyInfo[1]['content'] = user['company_email'];
          phoneController.text = companyInfo[2]['content'] = user['company_phone'];
          locationController.text = companyInfo[3]['content'] = user['company_location'];
          websiteController.text = companyInfo[4]['content'] = user['company_website'];
          industryController.text = companyInfo[5]['content'] = user['company_industry'];
          companySizeController.text = companyInfo[6]['content'] = user['company_size'];
          companyDescriptionController.text = companyInfo[7]['content'] = user['company_description'];
          tradeRegisterController.text = companyInfo[8]['content'] = user['trade_register_number'];
          taxIdentificationController.text = companyInfo[9]['content'] = user['tax_identification_number']; 

          companyInfo[0]['controller'] = companyNameController;
          companyInfo[1]['controller'] = emailController;
          companyInfo[2]['controller'] = phoneController;
          companyInfo[3]['controller'] = locationController;
          companyInfo[4]['controller'] = websiteController;
          companyInfo[5]['controller'] = industryController;
          companyInfo[6]['controller'] = companySizeController;
          companyInfo[7]['controller'] = companyDescriptionController;
          companyInfo[8]['controller'] = tradeRegisterController;
          companyInfo[9]['controller'] = taxIdentificationController;

        }
        else
        {
          jobSeekerNameController.text = jobseekerInfo[0]['content'] = user['full_name'];
          jobSeekerEmailController.text = jobseekerInfo[1]['content'] = user['job_seeker_email'];
          jobSeekerPhoneController.text = jobseekerInfo[2]['content'] = user['job_seeker_phone'] ?? "add your phone number";
          jobSeekerLocationController.text = jobseekerInfo[3]['content'] = user['job_seeker_address'] ?? "add your location";
          jobSeekerDescriptionController.text = jobseekerInfo[4]['content'] = user['about_me'] ?? "add your description";
          jobSeekerExperienceController.text = jobseekerInfo[5]['content'] = user['work_experience'] ?? "add your experience";
          jobSeekerEducationController.text = jobseekerInfo[6]['content'] = user['education'] ?? "add your level";
          jobSeekerSkillsController.text = jobseekerInfo[7]['content'] = user['skills'] ?? "add your skills";
          jobSeekerLanguagesController.text = jobseekerInfo[8]['content'] = user['languages'] ?? "add languages you speak";

          jobseekerInfo[0]['controller'] = jobSeekerNameController;
          jobseekerInfo[1]['controller'] = jobSeekerEmailController;
          jobseekerInfo[2]['controller'] = jobSeekerPhoneController;
          jobseekerInfo[3]['controller'] = jobSeekerLocationController;
          jobseekerInfo[4]['controller'] = jobSeekerDescriptionController;
          jobseekerInfo[5]['controller'] = jobSeekerExperienceController;
          jobseekerInfo[6]['controller'] = jobSeekerEducationController;
          jobseekerInfo[7]['controller'] = jobSeekerSkillsController;
          jobseekerInfo[8]['controller'] = jobSeekerLanguagesController;
        }
      });
    } else {
      setState(() {
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _fetchUserData();
    _isEditingMap = (widget.isCompany)
    ? List.generate(companyInfo.length, (_) => false)
    : List.generate(jobseekerInfo.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              height: AppSizes.getScreenHeight(context) * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profileBackground.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 65, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: AppSizes.getScreenHeight(context) * 0.15),
                          const Text(
                            "Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: _profilePic != null
                                      ? FileImage(_profilePic!)
                                      : _user[(widget.isCompany) ? 'company_logo' : 'profile_picture'] != null
                                          ? MemoryImage(base64Decode(_user[(widget.isCompany) ? 'company_logo' : 'profile_picture']))
                                          : const AssetImage('assets/icon.png') as ImageProvider,
                                  radius: 35, 
                                ),
                                Positioned(
                                  bottom: -2,
                                  right: -2,
                                  child: GestureDetector(
                                    onTap: () async {
                                      _isEditingPic = !_isEditingPic;
                                      if (_profilePic == null && _isEditingPic) {
                                        await _uploadPic(); 
                                        setState(() {});
                                      } else {
                                        await saveProfilePic(); 
                                        setState(() {
                                          _profilePic = null;
                                        });
                                      }
                                      setState(() {});
                                    },
                                    child: Icon(
                                      _isEditingPic ? Icons.check : Icons.edit,
                                      size: 15,
                                      color: AppColors.lightGreenColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.isCompany ? _user['company_name'] : _user['full_name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.isCompany ? "${_user['company_industry']}" : '${_user['job_seeker_address']}',
                                  style: const TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.settings_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(
                                  isCompany: (widget.isCompany) ? true : false,
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    (widget.isCompany) ? companyInfo.length : jobseekerInfo.length,
                itemBuilder: (context, index) {
                  final item =
                      (widget.isCompany) ? companyInfo[index] : jobseekerInfo[index];
                  return detailTile(
                    item["label"],
                    item["content"],
                    item["icon"],
                    item["controller"],
                    index,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget detailTile(String label, dynamic content, IconData icon, TextEditingController controller, int index)
  {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.lightGreenColor,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.blackTextColor,
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if(_isEditingTile(index))
                    {
                      saveChange(index);
                      _fetchUserData();
                    }
                    _toggleEditingTile( index);
                  });
                },
                child: Icon(
                  _isEditingTile(index) ? Icons.check : Icons.edit,
                  size: 20,
                  color: AppColors.lightGreenColor,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.primaryBackgroundColor),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 35),
              Expanded(
                child: _isEditingTile(index)
                    ? _buildEditingContent(label, content, controller)
                    : _buildReadOnlyContent(label, content,),
              ),
            ],
          ),
        ],
      ),
    );
  
  }

  Widget _buildEditingContent(String label, dynamic content, TextEditingController controller) {
    if (label == 'Work experience' || label == 'Education') {
      return _buildEditableWorkEducationContent(label, content, controller);
    }
    else if (label == 'Skills' || label == 'Languages') {
      return _buildEditableSkillsLanguagesContent(label, content, controller);
    }  
    else {
      return (label == "Company Size")?
        DropdownButtonFormField<String>(
          value: controller.text.isEmpty ? null : controller.text,
          onChanged: (newValue) {
            setState(() {
              controller.text = newValue!;
            });
          },
          dropdownColor: AppColors.primaryBackgroundColor,
          items: <String>[
            'Small Business',
            'Medium-Sized Business',
            'Large Business',
            'Enterprise',
          ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),),
          );
          }).toList(),
        )
      :TextFormField(
        controller: controller,
        cursorColor: AppColors.lightGreenColor,
        style: const TextStyle(
          color: AppColors.greyTextColor,
          fontSize: 14,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      );
    }
  }

  Widget _buildReadOnlyContent(String label, dynamic content) {
    if (label == 'Work experience' || label == 'Education') {
      return _buildWorkEducationContent(label, content);
    } else if (label == 'Skills' || label == 'Languages') {
      return _buildSkillsLanguagesContent(label, content);
    } else {
      return Text(
        content,
        style: const TextStyle(
          color: AppColors.greyTextColor,
          fontSize: 14,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  Widget _buildWorkEducationContent(String label, dynamic content) {
    final List<dynamic> contentList = generateContentList(content, label);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentList.map<Widget>((entry) {
        if (entry is Map<String, dynamic>) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entry.entries.map((e) {
                return Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.blueButtonColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      "${e.key} : ",
                      style: const TextStyle(
                        color: AppColors.blueButtonColor,
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${e.value}",
                      style: const TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildEditableWorkEducationContent(String label, dynamic content, TextEditingController controller) {
    final List<dynamic> contentList = generateContentList(content, label);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contentList.map<Widget>((entry) {
            if (entry is Map<String, dynamic>) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display all existing entries
                    ...entry.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, bottom: 12),
                        child: TextFormField(
                          initialValue: e.value.toString(),
                          decoration: InputDecoration(
                            labelText: e.key,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.blueButtonColor),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.blueButtonColor),
                            ),
                            labelStyle: const TextStyle(
                              color: AppColors.blueButtonColor,
                              fontSize: 15,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: AppColors.blueButtonColor,
                              fontSize: 15,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          ),
                          style: const TextStyle(
                            color: AppColors.greyTextColor,
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              entry[e.key] = newValue;
                              // Update the controller when fields change
                              controller.text = _generateControllerText(contentList, label);
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
        // Add button to allow adding new entries
        GestureDetector(
          onTap: () {
            _showAddEntryDialog(context, label, (newEntry) {
              setState(() {
                contentList.add(newEntry);
                 // Update the controller when a new entry is added
                controller.text = _generateControllerText(contentList, label);
              });
            });
          },
          child: const Icon(
            Icons.add,
            size: 20,
            color: AppColors.blueButtonColor,
          ),
        ),
      ],
    );
  }

  // Function to display a dialog to add a new entry
  void _showAddEntryDialog(BuildContext context, String label, Function(Map<String, String>) onAdd) {
    final TextEditingController field1Controller = TextEditingController();
    final TextEditingController field2Controller = TextEditingController();
    final TextEditingController field3Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New $label'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label == 'Work experience') ...[
                TextField(
                  controller: field1Controller,
                  decoration: const InputDecoration(labelText: 'Job Title'),
                ),
                TextField(
                  controller: field2Controller,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
                TextField(
                  controller: field3Controller,
                  decoration: const InputDecoration(labelText: 'Duration'),
                ),
              ] else if (label == 'Education') ...[
                TextField(
                  controller: field1Controller,
                  decoration: const InputDecoration(labelText: 'Degree'),
                ),
                TextField(
                  controller: field2Controller,
                  decoration: const InputDecoration(labelText: 'Institution'),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Create a new entry from the input fields
                Map<String, String> newEntry = {};
                if (label == 'Work experience') {
                  newEntry = {
                    'Job title': field1Controller.text,
                    'Company': field2Controller.text,
                    'Duration': field3Controller.text,
                  };
                } else if (label == 'Education') {
                  newEntry = {
                    'Degree': field1Controller.text,
                    'Institution': field2Controller.text,
                  };
                }
                onAdd(newEntry); 
                Navigator.pop(context); 
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Generate the text format for the controller
  String _generateControllerText(List<dynamic> contentList, String label) {
    List<String> formattedEntries = contentList.map((entry) {
      if (label == 'Work experience') {
        return '${entry['Job title']},${entry['Company']},${entry['Duration']}';
      } else if (label == 'Education') {
        return '${entry['Degree']},${entry['Institution']}';
      }
      return '';
    }).toList();
    // Join entries with '|' separator for the controller
    return formattedEntries.join('|');
  }

  List<dynamic> generateContentList(String content, String label) {
  List<dynamic> contentList = [];
  if (content.contains('|')) {
    List<String> entries = content.split('|');
    
    for (var entry in entries) {
      List<String> parts = entry.split(','); 

      if (label == "Work experience") {
        contentList.add({
          "Job title" : parts[0],
          "Company" : parts[1], 
          "Duration" : parts[2],
        });
      } else if (label == "Education") {
        contentList.add({
          "Degree": parts[0], 
          "Institution": parts[1], 
        });
      }
    }
  } else if(content.contains(',')) {
    List<String> parts = content.split(',');
    if (label == "Work experience") {
        contentList.add({
          "Job title" : parts[0],
          "Company" : parts[1], 
          "Duration" : parts[2],
        });
      } else if (label == "Education") {
        contentList.add({
          "Degree": parts[0], 
          "Institution": parts[1], 
        });
      }
  }
  
  return contentList;
}

  Widget _buildSkillsLanguagesContent(String label, String content) {
    final List<String> items = content.split(',').map((e) => e.trim()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Row(
              children: [
                Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.blueButtonColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

Widget _buildEditableSkillsLanguagesContent(
    String label, String content, TextEditingController controller) {
  List<String> items = content.split(',').map((e) => e.trim()).toList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          return TextFormField(
            initialValue: item,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.blueButtonColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.blueButtonColor),
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.greyTextColor,
            ),
            onChanged: (newValue) {
              setState(() {
                items[index] = newValue.trim();
                // Update the controller
                controller.text = items.join(', ');
              });
            },
          );
        }).toList(),
      ),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () {
        // Add new skill or language via dialog
          _showAddItemDialog(context, label, (newItem) {
            if (newItem.trim().isNotEmpty) {
              setState(() {
                items.add(newItem.trim());
                // Update the controller
                controller.text = items.join(', ');
              });
            }
          });
        },
        child: const Icon(
          Icons.add,
          size: 20,
          color: AppColors.blueButtonColor,
        ),
      ),   
    ],
  );
}

void _showAddItemDialog(BuildContext context, String label, Function(String) onAdd) {
  final TextEditingController newItemController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add a new $label'),
        content: TextField(
          controller: newItemController,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: AppColors.blueButtonColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: AppColors.blueButtonColor),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newItem = newItemController.text.trim();
              if (newItem.isNotEmpty) {
                onAdd(newItem);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

}

