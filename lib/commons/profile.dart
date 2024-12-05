import 'package:flutter/material.dart';
import 'package:khotwa/commons/constants.dart';
import '../data/profile_data.dart';
import 'package:khotwa/screens/company/settings/main_settings.dart';

class Profile extends StatelessWidget {
  final bool isCompany;

  const Profile({required this.isCompany});

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
              height: AppSizes.getScreenHeight(context) * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/profileBackground.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: ClipOval(
                                child: Image(
                                  image: isCompany
                                      ? const AssetImage(
                                          "assets/Sonatrach-Logo.png")
                                      : const NetworkImage(
                                          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
                                        ) as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isCompany ? 'SONATRACH' : "Zineb Berrekia",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  isCompany ? "Industry" : 'Media, Algeria',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
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
                                builder: (context) =>  SettingsPage(isCompany: (isCompany)? true : false,),
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
                    (isCompany) ? companyInfo.length : jobseekerInfo.length,
                itemBuilder: (context, index) {
                  final item =
                      (isCompany) ? companyInfo[index] : jobseekerInfo[index];
                  return DetailTile(
                    label: item["label"],
                    content: item["content"],
                    icon: item["icon"],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 266,
                height: 50,
                decoration: ShapeDecoration(
                  color: AppColors.lightGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
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
}

class DetailTile extends StatefulWidget {
  final String label;
  final dynamic content;
  final IconData icon;

  const DetailTile({
    required this.label,
    required this.content,
    required this.icon,
    Key? key,
  }) : super(key: key);

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
    } else if (widget.content is List<String>) {
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
    return const SizedBox.shrink();
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
