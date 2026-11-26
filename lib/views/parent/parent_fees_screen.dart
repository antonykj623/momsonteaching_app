import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/api_constants.dart';
import '../../logic/student_provider.dart';

class ParentFeesScreen extends StatelessWidget {
  const ParentFeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final child = studentProvider.currentChild;
    final fees = studentProvider.getFeesForStudent(child.id);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: child.feeDue > 0 ? Colors.orange.shade50 : Colors.green.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fee Summary (${child.name})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  'Current Balance Due: ₹${child.feeDue.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (child.feeDue > 0)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Pay Now (Opens Official Payment Portal)'),
                    onPressed: () async {
                      final uri = Uri.parse('${ApiConstants.externalPaymentUrl}?student_id=${child.id}');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Billing & Payment History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...fees.map((f) => Card(
              child: ListTile(
                title: Text(f.monthLabel),
                subtitle: Text(f.receiptRef != null ? 'Receipt: ${f.receiptRef}' : 'Awaiting Payment'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${f.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      f.status,
                      style: TextStyle(
                        color: f.status == 'Paid' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
