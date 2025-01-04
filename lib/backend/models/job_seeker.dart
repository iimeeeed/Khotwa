
class JobSeeker {
  final String fullName;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String? profilePicture;
  final String? aboutMe;
  final String? workExperience; // Comma-separated values, | separated for multiple entries
  final String? education; // Comma-separated values, | separated for multiple entries
  final String? skills; // Comma-separated values
  final String? languages; // Comma-separated values
  final String? jobPreferences; // Comma-separated values
  final String? jobTypePreferences; // Comma-separated values
  final String? jobLocationPreferences; // Comma-separated values
  final String? createdAt; // Defaults to current datetime

  JobSeeker({
    required this.fullName,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.profilePicture,
    this.aboutMe,
    this.workExperience,
    this.education,
    this.skills,
    this.languages,
    this.jobPreferences,
    this.jobTypePreferences,
    this.jobLocationPreferences,
    this.createdAt,
  });

  // Convert a JobSeeker object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'job_seeker_email': email,
      'job_seeker_password': password,
      'job_seeker_phone': phone,
      'job_seeker_address': address,
      'profile_picture': profilePicture,
      'about_me': aboutMe,
      'work_experience': workExperience,
      'education': education,
      'skills': skills,
      'languages': languages,
      'job_preferences': jobPreferences,
      'job_type_preferences': jobTypePreferences,
      'job_location_preferences': jobLocationPreferences,
      'created_at': createdAt,
    };
  }

  // Convert a Map object into a JobSeeker object
  factory JobSeeker.fromMap(Map<String, dynamic> map) {
    return JobSeeker(
      fullName: map['full_name'],
      email: map['job_seeker_email'],
      password: map['job_seeker_password'],
      phone: map['job_seeker_phone'],
      address: map['job_seeker_address'],
      profilePicture: map['profile_picture'],
      aboutMe: map['about_me'],
      workExperience: map['work_experience'],
      education: map['education'],
      skills: map['skills'],
      languages: map['languages'],
      jobPreferences: map['job_preferences'],
      jobTypePreferences: map['job_type_preferences'],
      jobLocationPreferences: map['job_location_preferences'],
      createdAt: map['created_at'],
    );
  }
}

