import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../logic/homework_provider.dart';

class TeacherHomeworkScreen extends StatelessWidget {
  const TeacherHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hwProvider = context.watch<HomeworkProvider>();
    final homeworks = hwProvider.allHomeworks;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homeworks.length,
      itemBuilder: (ctx, idx) {
        final hw = homeworks[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text('${hw.title} (${hw.subject})'),
            subtitle: Text(
              'Student ID: ${hw.studentId} • Due: ${DateFormat('dd MMM').format(hw.dueDate)}'
              'Status: ${hw.isSubmitted ? 'Submitted PDF Ready' : 'Pending Submission'}',
            ),
            isThreeLine: true,
            trailing: hw.isSubmitted
                ? ElevatedButton(
                    onPressed: () => _showFeedbackDialog(context, hw.id, hw.teacherFeedback ?? ''),
                    child: const Text('Review'),
                  )
                : const Chip(label: Text('Awaiting')),
          ),
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context, String hwId, String existing) {
    final ctrl = TextEditingController(text: existing);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Homework Feedback'),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Teacher Remarks'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<HomeworkProvider>().addTeacherFeedback(hwId, ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
