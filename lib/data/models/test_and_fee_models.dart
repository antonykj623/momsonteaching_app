import 'package:momsonteaching_app/data/models/user_model.dart';

class TestResultModel {
  final String id;
  final String studentId;
  final String subject;
  final String topic;
  final DateTime date;
  final double marksObtained;
  final double totalMarks;
  final String feedback;

  TestResultModel({
    required this.id,
    required this.studentId,
    required this.subject,
    required this.topic,
    required this.date,
    required this.marksObtained,
    required this.totalMarks,
    required this.feedback,
  });

  double get percentage => totalMarks > 0 ? (marksObtained / totalMarks) * 100 : 0;
}

class StudyNoteModel {
  final String id;
  final String studentId;
  final String subject;
  final String topic;
  final String fileName;
  final String fileUrl;
  final DateTime uploadedAt;

  StudyNoteModel({
    required this.id,
    required this.studentId,
    required this.subject,
    required this.topic,
    required this.fileName,
    required this.fileUrl,
    required this.uploadedAt,
  });
}

class FeeRecordModel {
  final String id;
  final String studentId;
  final String monthLabel;
  final double amount;
  final String status; // 'Paid', 'Due', 'Overdue'
  final DateTime? paidDate;
  final String? receiptRef;

  FeeRecordModel({
    required this.id,
    required this.studentId,
    required this.monthLabel,
    required this.amount,
    required this.status,
    this.paidDate,
    this.receiptRef,
  });
}

class ChatMessageModel {
  final String id;
  final String studentId;
  final String senderId;
  final String senderName;
  final UserRole senderRole;
  final String text;
  final String? attachmentUrl;
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.studentId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.text,
    this.attachmentUrl,
    required this.timestamp,
  });
}
