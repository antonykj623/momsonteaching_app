import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/student_provider.dart';

class ParentAcademicsScreen extends StatelessWidget {
  const ParentAcademicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final child = studentProvider.currentChild;
    final tests = studentProvider.getTestsForStudent(child.id);
    final notes = studentProvider.getNotesForStudent(child.id);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Test Results — ${child.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...tests.map((t) => Card(
              child: ListTile(
                title: Text('${t.subject}: ${t.topic}'),
                subtitle: Text(t.feedback),
                trailing: Text(
                  '${t.marksObtained}/${t.totalMarks}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )),
        const SizedBox(height: 20),
        Text('Study Materials & Notes — ${child.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...notes.map((n) => Card(
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(n.topic),
                subtitle: Text('${n.subject} • ${n.fileName}'),
                trailing: const Icon(Icons.download),
              ),
            )),
      ],
    );
  }
}
