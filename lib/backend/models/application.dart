class Application {
  final int id;
  final int jobId;
  final int jobSeekerId;
  final String applicationStatus; // e.g., Applied, Shortlisted, Interviewing, Rejected
  final String? resume; // Path or URL to the resume file
  final String? coverLetter; // Path or URL to the cover letter file
  final String createdAt;

  Application({
    required this.id,
    required this.jobId,
    required this.jobSeekerId,
    required this.applicationStatus,
    this.resume,
    this.coverLetter,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'job_id': jobId,
      'job_seeker_id': jobSeekerId,
      'application_status': applicationStatus,
      'resume': resume,
      'cover_letter': coverLetter,
      'created_at': createdAt,
    };
  }

  factory Application.fromMap(Map<String, dynamic> map) {
    return Application(
      id: map['id'],
      jobId: map['job_id'],
      jobSeekerId: map['job_seeker_id'],
      applicationStatus: map['application_status'],
      resume: map['resume'],
      coverLetter: map['cover_letter'],
      createdAt: map['created_at'],
    );
  }
}
