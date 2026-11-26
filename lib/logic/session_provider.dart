import 'package:flutter/material.dart';
import '../data/models/session_model.dart';

class SessionProvider with ChangeNotifier {
  final List<TuitionSessionModel> _sessions = [
    TuitionSessionModel(
      id: 'SES-01',
      studentId: 'S-01',
      studentName: 'Aarav Sharma',
      teacherId: 'T-101',
      teacherName: 'Anjali Menon',
      subject: 'Mathematics',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      meetLink: 'https://meet.google.com/abc-defg-hij',
      attendanceStatus: AttendanceStatus.pending,
      sharedGroupKey: 'SIBLING-GRP-1',
    ),
    TuitionSessionModel(
      id: 'SES-02',
      studentId: 'S-02',
      studentName: 'Diya Sharma',
      teacherId: 'T-101',
      teacherName: 'Anjali Menon',
      subject: 'Mathematics',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      // Siblings attending the same scheduled session share the Meet link
      meetLink: 'https://meet.google.com/abc-defg-hij',
      attendanceStatus: AttendanceStatus.pending,
      sharedGroupKey: 'SIBLING-GRP-1',
    ),
    TuitionSessionModel(
      id: 'SES-03',
      studentId: 'S-01',
      studentName: 'Aarav Sharma',
      teacherId: 'T-101',
      teacherName: 'Anjali Menon',
      subject: 'Science',
      startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      meetLink: 'https://meet.google.com/xyz-uvwx-rst',
      attendanceStatus: AttendanceStatus.present,
      topicTaught: 'Force and Pressure - Atmospheric Pressure Experiments',
      dailyRemark: 'Aarav answered all conceptual questions accurately.',
    ),
  ];

  List<TuitionSessionModel> get sessions => _sessions;

  List<TuitionSessionModel> getSessionsForStudent(String studentId) {
    return _sessions.where((s) => s.studentId == studentId).toList();
  }

  void addSession(TuitionSessionModel session) {
    _sessions.insert(0, session);
    notifyListeners();
  }

  void updateMeetLink(String sessionId, String link, {bool applyToSharedGroup = true}) {
    final idx = _sessions.indexWhere((s) => s.id == sessionId);
    if (idx != -1) {
      final groupKey = _sessions[idx].sharedGroupKey;
      _sessions[idx].meetLink = link;
      if (applyToSharedGroup && groupKey != null) {
        for (var s in _sessions) {
          if (s.sharedGroupKey == groupKey) {
            s.meetLink = link;
          }
        }
      }
      notifyListeners();
    }
  }

  void markAttendance(String sessionId, AttendanceStatus status) {
    final idx = _sessions.indexWhere((s) => s.id == sessionId);
    if (idx != -1) {
      _sessions[idx].attendanceStatus = status;
      notifyListeners();
    }
  }

  void submitPostClassUpdate({
    required String sessionId,
    required String topicTaught,
    required String dailyRemark,
  }) {
    final idx = _sessions.indexWhere((s) => s.id == sessionId);
    if (idx != -1) {
      _sessions[idx].topicTaught = topicTaught;
      _sessions[idx].dailyRemark = dailyRemark;
      notifyListeners();
    }
  }
}
