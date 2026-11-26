import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../logic/session_provider.dart';
import '../../logic/student_provider.dart';
import '../../data/models/session_model.dart';

class TeacherCalendarScreen extends StatelessWidget {
  const TeacherCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = context.watch<SessionProvider>().sessions;

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (ctx, idx) {
          final s = sessions[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.event)),
              title: Text('${s.studentName} — ${s.subject}'),
              subtitle: Text(
                '${DateFormat('EEE, dd MMM • hh:mm a').format(s.startTime)}'
                'Topic: ${s.topicTaught ?? 'Not recorded yet'}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSessionDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New 1-to-1 Session'),
      ),
    );
  }

  void _showCreateSessionDialog(BuildContext context) {
    final students = context.read<StudentProvider>().allStudents;
    String selectedStudentId = students.first.id;
    final subjectCtrl = TextEditingController(text: 'Mathematics');
    final linkCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Schedule 1-to-1 Session (No Approval Needed)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedStudentId,
              items: students
                  .map((st) => DropdownMenuItem(value: st.id, child: Text('${st.name} (${st.gradeClass})')))
                  .toList(),
              onChanged: (val) => selectedStudentId = val!,
              decoration: const InputDecoration(labelText: 'Select Student', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: subjectCtrl,
              decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: linkCtrl,
              decoration: const InputDecoration(labelText: 'Google Meet Link (Optional)', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final student = students.firstWhere((s) => s.id == selectedStudentId);
              context.read<SessionProvider>().addSession(
                    TuitionSessionModel(
                      id: 'SES-${DateTime.now().millisecondsSinceEpoch}',
                      studentId: student.id,
                      studentName: student.name,
                      teacherId: 'T-101',
                      teacherName: 'Anjali Menon',
                      subject: subjectCtrl.text.trim(),
                      startTime: DateTime.now().add(const Duration(days: 1)),
                      endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
                      meetLink: linkCtrl.text.trim().isEmpty ? null : linkCtrl.text.trim(),
                    ),
                  );
              Navigator.pop(ctx);
            },
            child: const Text('Create Session'),
          ),
        ],
      ),
    );
  }
}
