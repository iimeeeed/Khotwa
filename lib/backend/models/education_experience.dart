class EducationExperience {
  final int id;
  final int jobSeekerId;
  final String institutionName;
  final String? programDetails;
  final String startDate;
  final String? endDate;

  EducationExperience({
    required this.id,
    required this.jobSeekerId,
    required this.institutionName,
    this.programDetails,
    required this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'job_seeker_id': jobSeekerId,
      'institution_name': institutionName,
      'program_details': programDetails,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  factory EducationExperience.fromMap(Map<String, dynamic> map) {
    return EducationExperience(
      id: map['id'],
      jobSeekerId: map['job_seeker_id'],
      institutionName: map['institution_name'],
      programDetails: map['program_details'],
      startDate: map['start_date'],
      endDate: map['end_date'],
    );
  }
}
