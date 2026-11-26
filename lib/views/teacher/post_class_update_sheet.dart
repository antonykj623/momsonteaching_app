import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/session_model.dart';
import '../../data/models/homework_model.dart';
import '../../logic/session_provider.dart';
import '../../logic/homework_provider.dart';

/// Single Post-Class Update Form:
/// Routes Topic Taught -> Academic Calendar, Remark -> Daily Remarks, Homework -> Homework Module
class PostClassUpdateSheet extends StatefulWidget {
  final TuitionSessionModel session;
  const PostClassUpdateSheet({super.key, required this.session});

  @override
  State<PostClassUpdateSheet> createState() => _PostClassUpdateSheetState();
}

class _PostClassUpdateSheetState extends State<PostClassUpdateSheet> {
  late TextEditingController _topicCtrl;
  late TextEditingController _remarkCtrl;
  final _hwTitleCtrl = TextEditingController();
  final _hwDescCtrl = TextEditingController();
  bool _assignHomework = false;

  @override
  void initState() {
    super.initState();
    _topicCtrl = TextEditingController(text: widget.session.topicTaught ?? '');
    _remarkCtrl = TextEditingController(text: widget.session.dailyRemark ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Post-Class Update: ${widget.session.studentName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Save once — updates Academic Calendar, Daily Remarks & Homework automatically.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _topicCtrl,
              decoration: const InputDecoration(
                labelText: 'Topic Taught (Routes to Academic Calendar)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _remarkCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Individual Daily Remark (Parent Only)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Assign Homework in this Update'),
              value: _assignHomework,
              onChanged: (val) => setState(() => _assignHomework = val),
            ),
            if (_assignHomework) ...[
              TextField(
                controller: _hwTitleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Homework Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _hwDescCtrl,
                decoration: const InputDecoration(
                  labelText: 'Homework Instructions',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<SessionProvider>().submitPostClassUpdate(
                      sessionId: widget.session.id,
                      topicTaught: _topicCtrl.text.trim(),
                      dailyRemark: _remarkCtrl.text.trim(),
                    );

                if (_assignHomework && _hwTitleCtrl.text.trim().isNotEmpty) {
                  context.read<HomeworkProvider>().assignHomework(
                        HomeworkModel(
                          id: 'HW-${DateTime.now().millisecondsSinceEpoch}',
                          studentId: widget.session.studentId,
                          subject: widget.session.subject,
                          title: _hwTitleCtrl.text.trim(),
                          description: _hwDescCtrl.text.trim(),
                          dueDate: DateTime.now().add(const Duration(days: 2)),
                        ),
                      );
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Session update saved & routed to child records.')),
                );
              },
              child: const Text('Submit & Route Update'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
