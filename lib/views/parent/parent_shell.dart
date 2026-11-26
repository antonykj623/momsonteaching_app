import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/auth_provider.dart';
import '../../logic/student_provider.dart';
import 'parent_home_screen.dart';
import 'parent_homework_screen.dart';
import 'parent_academics_screen.dart';
import 'parent_fees_screen.dart';
import '../shared/messages_screen.dart';

class ParentShell extends StatefulWidget {
  const ParentShell({super.key});

  @override
  State<ParentShell> createState() => _ParentShellState();
}

class _ParentShellState extends State<ParentShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ParentHomeScreen(),
    ParentHomeworkScreen(),
    ParentAcademicsScreen(),
    ParentFeesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final children = studentProvider.getChildrenForParent('P-201');
    final currentChild = studentProvider.currentChild;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moms On Teaching'),
        actions: [
          // Multi-child Sibling Switcher right in the AppBar
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentChild.id,
              dropdownColor: const Color(0xFF2B4C7E),
              iconEnabledColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              items: children
                  .map((c) => DropdownMenuItem(value: c.id, child: Text('Child: ${c.name}')))
                  .toList(),
              onChanged: (val) {
                if (val != null) studentProvider.selectChild(val);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            tooltip: 'Teacher Chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MessagesScreen(
                    studentId: currentChild.id,
                    title: 'Chat (${currentChild.name})',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.document_scanner_outlined), label: 'Homework'),
          NavigationDestination(icon: Icon(Icons.school_outlined), label: 'Progress & Notes'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), label: 'Fees'),
        ],
      ),
    );
  }
}
