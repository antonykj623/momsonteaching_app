import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/auth_provider.dart';
import '../../data/models/test_and_fee_models.dart';

class MessagesScreen extends StatefulWidget {
  final String studentId;
  final String title;

  const MessagesScreen({super.key, required this.studentId, required this.title});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _msgCtrl = TextEditingController();
  final List<ChatMessageModel> _messages = [];

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Child-Specific 1-to-1 Thread (Student ID: ${widget.studentId})',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: _messages.isEmpty
                ? const Center(child: Text('No messages yet. Start a child-specific conversation.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (ctx, idx) {
                      final m = _messages[idx];
                      final isMe = m.senderId == user.id;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Card(
                          color: isMe ? const Color(0xFF2B4C7E) : Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              m.text,
                              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Type message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_msgCtrl.text.trim().isEmpty) return;
                    setState(() {
                      _messages.add(
                        ChatMessageModel(
                          id: 'MSG-${DateTime.now().millisecondsSinceEpoch}',
                          studentId: widget.studentId,
                          senderId: user.id,
                          senderName: user.name,
                          senderRole: user.role,
                          text: _msgCtrl.text.trim(),
                          timestamp: DateTime.now(),
                        ),
                      );
                      _msgCtrl.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
