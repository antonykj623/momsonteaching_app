class HomeworkModel {
  final String id;
  final String studentId;
  final String subject;
  final String title;
  final String description;
  final DateTime dueDate;
  String? submittedPdfPath;
  DateTime? submittedAt;
  String? teacherFeedback;
  String? gradeOrScore;

  HomeworkModel({
    required this.id,
    required this.studentId,
    required this.subject,
    required this.title,
    required this.description,
    required this.dueDate,
    this.submittedPdfPath,
    this.submittedAt,
    this.teacherFeedback,
    this.gradeOrScore,
  });

  bool get isLocked => DateTime.now().isAfter(dueDate);
  bool get isSubmitted => submittedPdfPath != null && submittedPdfPath!.isNotEmpty;
}
