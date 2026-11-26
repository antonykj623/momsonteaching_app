import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../logic/session_provider.dart';
import '../../data/models/session_model.dart';
import 'post_class_update_sheet.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = context.watch<SessionProvider>();
    final sessions = sessionProvider.sessions;

    final pendingAttendance = sessions.where((s) => s.attendanceStatus == AttendanceStatus.pending).length;
    final missingLinks = sessions.where((s) => s.meetLink == null || s.meetLink!.isEmpty).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            _StatCard(title: "Today's Sessions", value: '${sessions.length}', color: Colors.blue),
            const SizedBox(width: 12),
            _StatCard(title: 'Pending Attendance', value: '$pendingAttendance', color: Colors.orange),
            const SizedBox(width: 12),
            _StatCard(title: 'Missing Meet Links', value: '$missingLinks', color: Colors.red),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'One-to-One Student Sessions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...sessions.map((session) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${session.studentName} • ${session.subject}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          label: Text(session.attendanceStatus.name.toUpperCase()),
                          backgroundColor: session.attendanceStatus == AttendanceStatus.present
                              ? Colors.green.shade100
                              : Colors.amber.shade100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Time: ${DateFormat('dd MMM, hh:mm a').format(session.startTime)} (${session.durationHours.toStringAsFixed(1)} hrs)',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    if (session.sharedGroupKey != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Shared Sibling Session Link Active',
                          style: TextStyle(color: Colors.indigo.shade700, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    const Divider(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          icon: const Icon(Icons.video_call, size: 18),
                          label: Text(session.meetLink == null ? 'Add Meet Link' : 'Edit Meet Link'),
                          onPressed: () => _showMeetLinkDialog(context, session),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.post_add, size: 18),
                          label: const Text('Post-Class Update'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => PostClassUpdateSheet(session: session),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }

  void _showMeetLinkDialog(BuildContext context, TuitionSessionModel session) {
    final controller = TextEditingController(text: session.meetLink ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Google Meet Link (${session.studentName})'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Paste Google Meet URL',
                hintText: 'https://meet.google.com/xxx-xxxx-xxx',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate Meet Link via Connected Google Account'),
              onPressed: () {
                controller.text = 'https://meet.google.com/mot-${DateTime.now().millisecond}-live';
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<SessionProvider>().updateMeetLink(session.id, controller.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save Link'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
