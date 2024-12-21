class ProfessionalExperience {
  final int id;
  final int jobSeekerId;
  final String jobTitle;
  final String jobDetails;
  final String startDate;
  final String? endDate;
  final bool isCurrentJob;

  ProfessionalExperience({
    required this.id,
    required this.jobSeekerId,
    required this.jobTitle,
    required this.jobDetails,
    required this.startDate,
    this.endDate,
    this.isCurrentJob = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'job_seeker_id': jobSeekerId,
      'job_title': jobTitle,
      'job_details': jobDetails,
      'start_date': startDate,
      'end_date': endDate,
      'is_current_job': isCurrentJob ? 1 : 0,
    };
  }

  factory ProfessionalExperience.fromMap(Map<String, dynamic> map) {
    return ProfessionalExperience(
      id: map['id'],
      jobSeekerId: map['job_seeker_id'],
      jobTitle: map['job_title'],
      jobDetails: map['job_details'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      isCurrentJob: map['is_current_job'] == 1,
    );
  }
}
