class StudentModel {
  final String id;
  final String name;
  final String gradeClass;
  final List<String> subjects;
  final String parentId;
  final List<String> assignedTeacherIds;
  final bool isActive;
  final double feeDue;

  StudentModel({
    required this.id,
    required this.name,
    required this.gradeClass,
    required this.subjects,
    required this.parentId,
    required this.assignedTeacherIds,
    this.isActive = true,
    this.feeDue = 0.0,
  });
}
