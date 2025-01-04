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
  final JobSeekersRepository _jobSeekersRepository = JobSeekersRepository();

  final CompaniesRepository _companiesRepository = CompaniesRepository();

  late Map _user ;

  File? _profilePic;
  Uint8List? _picBytes;

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

  // Fetch the user data based on the id
  Future<void> _fetchUserData() async {
    final user = (widget.isCompany)? await _companiesRepository.getById(widget.id) : await _jobSeekersRepository.getById(widget.id);
    if (user != null) {
      setState(() {
        _user = user; 
      });
    } else {
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
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
                                      if (_profilePic == null) {
                                        await _uploadPic(); 
                                        setState(() {});
                                      } else {
                                        await saveProfilePic(); 
                                        setState(() {
                                          _profilePic = null;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      _profilePic == null ? Icons.edit : Icons.check,
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
                                  widget.isCompany ? "Industry" : 'Media, Algeria',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    (widget.isCompany) ? companyInfo.length : jobseekerInfo.length,
                itemBuilder: (context, index) {
                  final item =
                      (widget.isCompany) ? companyInfo[index] : jobseekerInfo[index];
                  return DetailTile(
                    label: item["label"],
                    content: item["content"],
                    icon: item["icon"],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DetailTile extends StatefulWidget {
  final String label;
  final dynamic content;
  final IconData icon;

  const DetailTile({
    required this.label,
    required this.content,
    required this.icon,
    super.key,
  });

  @override
  _DetailTileState createState() => _DetailTileState();
}

class _DetailTileState extends State<DetailTile> {
  late TextEditingController _controller;
  bool _isEditing = false;

  final List<int> _selectedIndices = [0];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.content is String ? widget.content : '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                widget.icon,
                color: AppColors.lightGreenColor,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
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
                    _isEditing = !_isEditing;
                  });
                },
                child: Icon(
                  _isEditing ? Icons.check : Icons.edit,
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
                child: _isEditing
                    ? _buildEditingContent()
                    : _buildReadOnlyContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditingContent() {
    if (widget.content is List<Map>) {
      return _buildEditableWorkEducationContent();
    } else if (widget.content is List<String>) {}
    if (widget.label == "Skills" ||
        widget.label == "Languages" ||
        widget.label == "Industry") {
      return _buildEditableChipContent();
    } else {
      return TextFormField(
        controller: _controller,
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

  Widget _buildReadOnlyContent() {
    if (widget.content is List<Map>) {
      return _buildWorkEducationContent();
    } else if (widget.content is List<String>) {
      if (widget.label == "Skills" ||
          widget.label == "Languages" ||
          widget.label == "Industry") {
        return _buildChipContent();
      }
    } else {
      return Text(
        _controller.text,
        style: const TextStyle(
          color: AppColors.greyTextColor,
          fontSize: 14,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildWorkEducationContent() {
    final List<dynamic> contentList = widget.content as List<dynamic>;

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

  Widget _buildEditableWorkEducationContent() {
    final List<dynamic> contentList = widget.content as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentList.map<Widget>((entry) {
        if (entry is Map<String, dynamic>) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entry.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    bottom: 12,
                  ),
                  child: TextFormField(
                    initialValue: e.value.toString(),
                    decoration: InputDecoration(
                      labelText: e.key,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: AppColors.blueButtonColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: AppColors.blueButtonColor),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
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
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  List<String> _getVisibleTags() {
    List<String> tags = widget.content as List<String>;
    return _isEditing ? tags : tags.take(6).toList();
  }

  Widget _buildChipContent() {
    final List<String> tags = _getVisibleTags();
    return Wrap(
      spacing: 5.0,
      runSpacing: 5.0,
      children: tags.map((tag) {
        int index = tags.indexOf(tag);
        bool isSelected = _selectedIndices.contains(index);

        return RawChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (bool selected) {
            if (_isEditing) {
              setState(() {
                if (selected) {
                  _selectedIndices.add(index);
                } else {
                  _selectedIndices.remove(index);
                }
              });
            }
          },
          selectedColor: AppColors.blueButtonColor,
          backgroundColor: AppColors.primaryBackgroundColor,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.transparent),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEditableChipContent() {
    final List<String> tags = _getVisibleTags();
    return Wrap(
      spacing: 5.0,
      runSpacing: 5.0,
      children: tags.map((tag) {
        int index = tags.indexOf(tag);
        bool isSelected = _selectedIndices.contains(index);

        return RawChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (bool selected) {
            if (_isEditing) {
              setState(() {
                if (selected) {
                  _selectedIndices.add(index);
                } else {
                  _selectedIndices.remove(index);
                }
              });
            }
          },
          selectedColor: AppColors.blueButtonColor,
          backgroundColor: AppColors.primaryBackgroundColor,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.transparent),
          ),
        );
      }).toList(),
    );
  }
}
