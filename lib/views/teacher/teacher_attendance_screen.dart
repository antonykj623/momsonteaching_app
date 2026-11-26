import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/session_provider.dart';
import '../../data/models/session_model.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = context.watch<SessionProvider>();
    final sessions = sessionProvider.sessions;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Manual Attendance Marking (P / A / L)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Joining Google Meet does not auto-mark attendance. Mark manually below.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        ...sessions.map((session) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${session.studentName} • ${session.subject}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    SegmentedButton<AttendanceStatus>(
                      segments: const [
                        ButtonSegment(value: AttendanceStatus.present, label: Text('Present')),
                        ButtonSegment(value: AttendanceStatus.absent, label: Text('Absent')),
                        ButtonSegment(value: AttendanceStatus.late, label: Text('Late')),
                      ],
                      selected: {
                        session.attendanceStatus == AttendanceStatus.pending
                            ? AttendanceStatus.present
                            : session.attendanceStatus
                      },
                      onSelectionChanged: (newSelection) {
                        sessionProvider.markAttendance(session.id, newSelection.first);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
