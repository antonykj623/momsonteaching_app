import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../logic/student_provider.dart';
import '../../logic/homework_provider.dart';
import 'homework_scanner_screen.dart';

class ParentHomeworkScreen extends StatelessWidget {
  const ParentHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final child = context.watch<StudentProvider>().currentChild;
    final homeworks = context.watch<HomeworkProvider>().getHomeworksForStudent(child.id);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homeworks.length,
      itemBuilder: (ctx, idx) {
        final hw = homeworks[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${hw.subject}: ${hw.title}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Chip(
                      label: Text(hw.isLocked ? 'LOCKED' : (hw.isSubmitted ? 'SUBMITTED' : 'PENDING')),
                      backgroundColor: hw.isLocked
                          ? Colors.grey.shade300
                          : (hw.isSubmitted ? Colors.green.shade100 : Colors.orange.shade100),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(hw.description),
                const SizedBox(height: 6),
                Text(
                  'Due: ${DateFormat('dd MMM yyyy, hh:mm a').format(hw.dueDate)}',
                  style: TextStyle(color: hw.isLocked ? Colors.red : Colors.grey.shade700, fontSize: 13),
                ),
                if (hw.teacherFeedback != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Teacher Feedback: ${hw.teacherFeedback}'),
                  ),
                ],
                const SizedBox(height: 12),
                if (!hw.isLocked)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.document_scanner),
                    label: Text(hw.isSubmitted ? 'Replace Submission (Scan PDF)' : 'Scan Pages & Submit PDF'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HomeworkScannerScreen(homework: hw)),
                      );
                    },
                  )
                else
                  const Text(
                    'Deadline passed — submission is locked (read-only).',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
