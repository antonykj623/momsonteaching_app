import 'package:flutter/material.dart';
import '../data/models/homework_model.dart';

class HomeworkProvider with ChangeNotifier {
  final List<HomeworkModel> _homeworks = [
    HomeworkModel(
      id: 'HW-01',
      studentId: 'S-01',
      subject: 'Mathematics',
      title: 'Exercise 2.4 Word Problems',
      description: 'Solve questions 1 to 8 in your notebook, scan all pages into one PDF, and upload.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    HomeworkModel(
      id: 'HW-02',
      studentId: 'S-02',
      subject: 'English',
      title: 'Paragraph Writing: My Favourite Season',
      description: 'Write 150 words neatly and submit before the deadline.',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    HomeworkModel(
      id: 'HW-03',
      studentId: 'S-01',
      subject: 'Science',
      title: 'Diagram of Human Eye',
      description: 'Draw and label parts of the human eye.',
      dueDate: DateTime.now().subtract(const Duration(days: 1)), // Expired -> Locked
      submittedPdfPath: '/storage/emulated/0/Download/Aarav_Eye_Diagram.pdf',
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
      teacherFeedback: 'Neat labelling and clear diagram.',
    ),
  ];

  List<HomeworkModel> get allHomeworks => _homeworks;

  List<HomeworkModel> getHomeworksForStudent(String studentId) {
    return _homeworks.where((h) => h.studentId == studentId).toList();
  }

  void assignHomework(HomeworkModel homework) {
    _homeworks.insert(0, homework);
    notifyListeners();
  }

  bool submitOrReplaceHomework(String homeworkId, String pdfPath) {
    final idx = _homeworks.indexWhere((h) => h.id == homeworkId);
    if (idx == -1) return false;
    if (_homeworks[idx].isLocked) return false; // Locked after deadline

    _homeworks[idx].submittedPdfPath = pdfPath;
    _homeworks[idx].submittedAt = DateTime.now();
    notifyListeners();
    return true;
  }

  void addTeacherFeedback(String homeworkId, String feedback) {
    final idx = _homeworks.indexWhere((h) => h.id == homeworkId);
    if (idx != -1) {
      _homeworks[idx].teacherFeedback = feedback;
      notifyListeners();
    }
  }
}
