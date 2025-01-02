class Job {
  final int companyId;
  final String jobTitle;
  final String jobDescription;
  final String? jobCategory;
  final String? jobSubCategory;
  final String jobLocation;
  final String? jobAddress;
  final String? jobType; // e.g., Full-time, Part-time, Internship
  final double? salaryLowerBound;
  final double? salaryUpperBound;
  final String? jobFacilities;
  final String? jobResponsibilities; 
  final String? requirements; // Stored as a comma-separated string
  final String createdAt;

  Job({
    required this.companyId,
    required this.jobTitle,
    required this.jobDescription,
    this.jobCategory,
    this.jobSubCategory,
    required this.jobLocation,
    this.jobAddress,
    this.jobType,
    this.salaryLowerBound,
    this.salaryUpperBound,
    this.jobFacilities,
    this.jobResponsibilities,  
    this.requirements,  
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_category': jobCategory,
      'job_sub_category': jobSubCategory,
      'job_location': jobLocation,
      'job_address': jobAddress,
      'job_type': jobType,
      'salary_lower_bound': salaryLowerBound,
      'salary_upper_bound': salaryUpperBound,
      'job_facilities': jobFacilities,
      'job_responsibilities': jobResponsibilities,
      'job_requirements': requirements,
      'created_at': createdAt,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      companyId: map['company_id'],
      jobTitle: map['job_title'],
      jobDescription: map['job_description'],
      jobCategory: map['job_category'],
      jobSubCategory: map['job_sub_category'],
      jobLocation: map['job_location'],
      jobAddress: map['job_address'],
      jobType: map['job_type'],
      salaryLowerBound: map['salary_lower_bound'],
      salaryUpperBound: map['salary_upper_bound'],
      jobFacilities: map['job_facilities'],
      jobResponsibilities: map['job_responsibilities'], 
      requirements: map['job_requirements'],
      createdAt: map['created_at'],
    );
  }
}
       
        
        
        