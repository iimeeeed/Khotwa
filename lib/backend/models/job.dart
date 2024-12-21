class Job {
  final int id;
  final int companyId;
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final String? jobType; // e.g., Full-time, Part-time, Internship
  final double? salary;
  final String? skillsRequired; // Stored as a comma-separated string
  final String? jobCategory;
  final String? experienceLevel; // e.g., Entry, Mid, Senior
  final String applicationDeadline;
  final String createdAt;

  Job({
    required this.id,
    required this.companyId,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    this.jobType,
    this.salary,
    this.skillsRequired,
    this.jobCategory,
    this.experienceLevel,
    required this.applicationDeadline,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_id': companyId,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_location': jobLocation,
      'job_type': jobType,
      'salary': salary,
      'skills_required': skillsRequired,
      'job_category': jobCategory,
      'experience_level': experienceLevel,
      'application_deadline': applicationDeadline,
      'created_at': createdAt,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'],
      companyId: map['company_id'],
      jobTitle: map['job_title'],
      jobDescription: map['job_description'],
      jobLocation: map['job_location'],
      jobType: map['job_type'],
      salary: map['salary'],
      skillsRequired: map['skills_required'],
      jobCategory: map['job_category'],
      experienceLevel: map['experience_level'],
      applicationDeadline: map['application_deadline'],
      createdAt: map['created_at'],
    );
  }
}
