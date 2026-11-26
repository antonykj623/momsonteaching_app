enum AttendanceStatus { pending, present, absent, late }

class TuitionSessionModel {
  final String id;
  final String studentId;
  final String studentName;
  final String teacherId;
  final String teacherName;
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  String? meetLink;
  AttendanceStatus attendanceStatus;
  String? topicTaught;
  String? dailyRemark;
  String? sharedGroupKey; // Used if siblings share a session Meet link

  TuitionSessionModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.teacherId,
    required this.teacherName,
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.meetLink,
    this.attendanceStatus = AttendanceStatus.pending,
    this.topicTaught,
    this.dailyRemark,
    this.sharedGroupKey,
  });

  double get durationHours => endTime.difference(startTime).inMinutes / 60.0;
}
