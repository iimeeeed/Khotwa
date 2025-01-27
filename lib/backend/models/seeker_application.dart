class SeekerApplication {
  final int id;
  final int jobId;
  final int jobSeekerId;
  final String cvFile;
  final String motivationFile;
  final String? portfolioLink;
  final String applicationStatus;
  final String createdAt;

  SeekerApplication({
    required this.id,
    required this.jobId,
    required this.jobSeekerId,
    required this.cvFile,
    required this.motivationFile,
    this.portfolioLink,
    required this.applicationStatus,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'job_id': jobId,
      'job_seeker_id': jobSeekerId,
      'cv_file': cvFile,
      'motivation_file': motivationFile,
      'portfolio_link': portfolioLink,
      'application_status': applicationStatus,
      'created_at': createdAt,
    };
  }

  factory SeekerApplication.fromMap(Map<String, dynamic> map) {
    return SeekerApplication(
      id: map['id'],
      jobId: map['job_id'],
      jobSeekerId: map['job_seeker_id'],
      cvFile: map['cv_file'],
      motivationFile: map['motivation_file'],
      portfolioLink: map['portfolio_link'],
      applicationStatus: map['application_status'],
      createdAt: map['created_at'],
    );
  }
}
