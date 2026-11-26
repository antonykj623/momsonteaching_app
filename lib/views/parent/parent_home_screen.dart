import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../logic/student_provider.dart';
import '../../logic/session_provider.dart';
import '../../logic/homework_provider.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final child = context.watch<StudentProvider>().currentChild;
    final sessions = context.watch<SessionProvider>().getSessionsForStudent(child.id);
    final homeworks = context.watch<HomeworkProvider>().getHomeworksForStudent(child.id);
    final pendingHwCount = homeworks.where((h) => !h.isSubmitted).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: const Color(0xFF2B4C7E),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${child.gradeClass} • Subjects: ${child.subjects.join(", ")}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pending Homework: $pendingHwCount',
                      style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Fee Due: ₹${child.feeDue.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Upcoming & Recent Classes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...sessions.map((s) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${s.subject} with ${s.teacherName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Chip(label: Text(s.attendanceStatus.name.toUpperCase())),
                      ],
                    ),
                    Text(DateFormat('EEE, dd MMM • hh:mm a').format(s.startTime)),
                    if (s.topicTaught != null) ...[
                      const SizedBox(height: 6),
                      Text('Topic Taught: ${s.topicTaught}', style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                    if (s.dailyRemark != null) ...[
                      const SizedBox(height: 4),
                      Text('Teacher Remark: "${s.dailyRemark}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                    if (s.meetLink != null) ...[
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.video_call),
                        label: const Text('Join Class (Google Meet)'),
                        onPressed: () async {
                          final uri = Uri.parse(s.meetLink!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    ]
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
