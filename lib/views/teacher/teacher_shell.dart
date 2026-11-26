import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/auth_provider.dart';
import 'teacher_home_screen.dart';
import 'teacher_calendar_screen.dart';
import 'teacher_attendance_screen.dart';
import 'teacher_homework_screen.dart';
import 'teacher_tests_notes_screen.dart';
import '../shared/messages_screen.dart';

class TeacherShell extends StatefulWidget {
  const TeacherShell({super.key});

  @override
  State<TeacherShell> createState() => _TeacherShellState();
}

class _TeacherShellState extends State<TeacherShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TeacherHomeScreen(),
    TeacherCalendarScreen(),
    TeacherAttendanceScreen(),
    TeacherHomeworkScreen(),
    TeacherTestsNotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('MOT Teacher • ${user?.name ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            tooltip: 'Parent Messages',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MessagesScreen(studentId: 'S-01', title: 'Parent Chat: Aarav Sharma')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Schedule'),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), label: 'Attendance'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), label: 'Homework'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Tests & Notes'),
        ],
      ),
    );
  }
}
