import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/auth_provider.dart';
import '../../logic/student_provider.dart';
import '../../logic/session_provider.dart';

class AdminShell extends StatelessWidget {
  const AdminShell({super.key});

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentProvider>().allStudents;
    final sessions = context.watch<SessionProvider>().sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MOT Admin & Operations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Operational Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('${students.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const Text('Active Students'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('${sessions.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const Text('Scheduled Sessions'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Billing & Fee Management (Admin Only)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...students.map((st) => Card(
                child: ListTile(
                  title: Text('${st.name} (${st.gradeClass})'),
                  subtitle: Text('Current Fee Due: ₹${st.feeDue.toStringAsFixed(0)}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      context.read<StudentProvider>().updateStudentFeeDue(st.id, st.feeDue == 0 ? 3500 : 0);
                    },
                    child: Text(st.feeDue > 0 ? 'Mark Paid' : 'Add Bill'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
