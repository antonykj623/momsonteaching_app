import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/student_provider.dart';
import '../../data/models/test_and_fee_models.dart';

class TeacherTestsNotesScreen extends StatelessWidget {
  const TeacherTestsNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final tests = studentProvider.getTestsForStudent('S-01');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tests & Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Enter Test Marks'),
              onPressed: () {
                studentProvider.addTestResult(
                  TestResultModel(
                    id: 'TST-${DateTime.now().millisecondsSinceEpoch}',
                    studentId: 'S-01',
                    subject: 'Science',
                    topic: 'Chapter 11: Force and Pressure',
                    date: DateTime.now(),
                    marksObtained: 18,
                    totalMarks: 20,
                    feedback: 'Very good understanding of numericals.',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New test result published to Parent portal.')),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...tests.map((t) => Card(
              child: ListTile(
                title: Text('${t.subject}: ${t.topic}'),
                subtitle: Text('Feedback: ${t.feedback}'),
                trailing: Text(
                  '${t.marksObtained}/${t.totalMarks}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )),
      ],
    );
  }
}
