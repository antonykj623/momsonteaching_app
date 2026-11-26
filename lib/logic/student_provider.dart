import 'package:flutter/material.dart';
import '../data/models/student_model.dart';
import '../data/models/test_and_fee_models.dart';

class StudentProvider with ChangeNotifier {
  String _selectedChildId = 'S-01';

  final List<StudentModel> _students = [
    StudentModel(
      id: 'S-01',
      name: 'Aarav Sharma',
      gradeClass: 'Grade 8 - CBSE',
      subjects: ['Mathematics', 'Science'],
      parentId: 'P-201',
      assignedTeacherIds: ['T-101'],
      feeDue: 3500.00,
    ),
    StudentModel(
      id: 'S-02',
      name: 'Diya Sharma',
      gradeClass: 'Grade 5 - CBSE',
      subjects: ['Mathematics', 'English'],
      parentId: 'P-201',
      assignedTeacherIds: ['T-101'],
      feeDue: 0.00,
    ),
  ];

  final List<TestResultModel> _testResults = [
    TestResultModel(
      id: 'TST-1',
      studentId: 'S-01',
      subject: 'Mathematics',
      topic: 'Linear Equations in One Variable',
      date: DateTime.now().subtract(const Duration(days: 4)),
      marksObtained: 23,
      totalMarks: 25,
      feedback: 'Strong algebraic steps. Double-check sign changes during transposition.',
    ),
    TestResultModel(
      id: 'TST-2',
      studentId: 'S-02',
      subject: 'English',
      topic: 'Comprehension & Tenses',
      date: DateTime.now().subtract(const Duration(days: 2)),
      marksObtained: 19,
      totalMarks: 20,
      feedback: 'Excellent vocabulary and sentence framing.',
    ),
  ];

  final List<StudyNoteModel> _notes = [
    StudyNoteModel(
      id: 'NOTE-1',
      studentId: 'S-01',
      subject: 'Mathematics',
      topic: 'Algebra Formula Sheet',
      fileName: 'Algebra_Formulas_Gr8.pdf',
      fileUrl: 'https://mot.com/notes/algebra.pdf',
      uploadedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    StudyNoteModel(
      id: 'NOTE-2',
      studentId: 'S-02',
      subject: 'Mathematics',
      topic: 'Fractions Worksheet',
      fileName: 'Fractions_Practice_Gr5.pdf',
      fileUrl: 'https://mot.com/notes/fractions.pdf',
      uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final List<FeeRecordModel> _feeRecords = [
    FeeRecordModel(
      id: 'FEE-101',
      studentId: 'S-01',
      monthLabel: 'November 2026',
      amount: 3500.00,
      status: 'Due',
    ),
    FeeRecordModel(
      id: 'FEE-100',
      studentId: 'S-01',
      monthLabel: 'October 2026',
      amount: 3500.00,
      status: 'Paid',
      paidDate: DateTime(2026, 10, 5),
      receiptRef: 'MOT-REC-8841',
    ),
    FeeRecordModel(
      id: 'FEE-102',
      studentId: 'S-02',
      monthLabel: 'November 2026',
      amount: 3000.00,
      status: 'Paid',
      paidDate: DateTime(2026, 11, 3),
      receiptRef: 'MOT-REC-9012',
    ),
  ];

  List<StudentModel> get allStudents => _students;
  String get selectedChildId => _selectedChildId;

  StudentModel get currentChild =>
      _students.firstWhere((s) => s.id == _selectedChildId, orElse: () => _students.first);

  void selectChild(String childId) {
    _selectedChildId = childId;
    notifyListeners();
  }

  List<StudentModel> getChildrenForParent(String parentId) {
    return _students.where((s) => s.parentId == parentId).toList();
  }

  List<TestResultModel> getTestsForStudent(String studentId) {
    return _testResults.where((t) => t.studentId == studentId).toList();
  }

  List<StudyNoteModel> getNotesForStudent(String studentId) {
    return _notes.where((n) => n.studentId == studentId).toList();
  }

  List<FeeRecordModel> getFeesForStudent(String studentId) {
    return _feeRecords.where((f) => f.studentId == studentId).toList();
  }

  void addTestResult(TestResultModel result) {
    _testResults.insert(0, result);
    notifyListeners();
  }

  void addStudyNote(StudyNoteModel note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void updateStudentFeeDue(String studentId, double newDue) {
    final idx = _students.indexWhere((s) => s.id == studentId);
    if (idx != -1) {
      final old = _students[idx];
      _students[idx] = StudentModel(
        id: old.id,
        name: old.name,
        gradeClass: old.gradeClass,
        subjects: old.subjects,
        parentId: old.parentId,
        assignedTeacherIds: old.assignedTeacherIds,
        isActive: old.isActive,
        feeDue: newDue,
      );
      notifyListeners();
    }
  }
}
