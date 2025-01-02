

class JobSeeker {
  final String fullName;
  final String email;
  final String? phone;
  final String? address;
  final String password;
  final String? aboutMe;
  final String? profilePicture;
  final String? interests;
  final String? jobTypes;
  final String? jobPreferences;
  final String? createdAt;

  JobSeeker({
    required this.fullName,
    required this.email,
    this.phone,
    this.address,
    required this.password,
    this.aboutMe,
    this.profilePicture,
    this.interests,
    this.jobTypes,
    this.jobPreferences,
    this.createdAt,
  });

  // Convert a JobSeeker object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'job_seeker_email': email,
      'job_seeker_phone': phone,
      'job_seeker_address': address,
      'job_seeker_password': password,
      'about_me': aboutMe,
      'profile_picture': profilePicture,
      'interests': interests,
      'job_types': jobTypes,
      'job_preferences': jobPreferences,
      'created_at': createdAt,
    };
  }

  // Convert a Map object into a JobSeeker object
  factory JobSeeker.fromMap(Map<String, dynamic> map) {
    return JobSeeker(
      fullName: map['full_name'],
      email: map['job_seeker_email'],
      phone: map['job_seeker_phone'],
      address: map['job_seeker_address'],
      password: map['job_seeker_password'],
      aboutMe: map['about_me'],
      profilePicture: map['profile_picture'],
      interests: map['interests'],
      jobTypes: map['job_types'],
      jobPreferences: map['job_preferences'],
      createdAt: map['created_at'],
    );
  }
}
