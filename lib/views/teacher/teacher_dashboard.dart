import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/teacher/studentlist.dart';

import 'attendancereport.dart';
import 'classroom.dart';
import 'homeworklist.dart';
import 'importantnotes.dart';
import 'markattendance.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Example state variable (e.g., tracking selected menu or notifications)
  int _notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141E46),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Moms on Teaching',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              setState(() {
                // Example state change
                _notificationCount = 0;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFF0D1B2A),
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Greeshma T P',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '8th,9th,10th',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Chemistry,Physics,Maths',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Mobile Number Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [
                    Text(
                      'Mobile number',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 24),
                    Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 24),
                    Text(
                      '98745671231',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Grid of Dashboard Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
                children: [
                  _buildDashboardCard(
                    title: 'Students',
                    icon: Icons.people_outline,
                    color: const Color(0xFF3366CC),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  StudentListScreen(),
                        ),
                      );

                    },
                  ),
                  _buildDashboardCard(
                    title: 'Attendance',
                    icon: Icons.calendar_today_outlined,
                    color: const Color(0xFF4A8420),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  MarkAttendanceScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Class Room',
                    icon: Icons.class_outlined,
                    color: const Color(0xFF7A1C21),
                    onTap: () {


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ClassRoomScreen(),
                        ),
                      );

                    },
                  ),
                  _buildDashboardCard(
                    title: 'Home Works',
                    icon: Icons.menu_book_outlined,
                    color: const Color(0xFF2E1A72),
                    onTap: () {



                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HomeworkListScreen(),
                        ),
                      );



                    },
                  ),
                  _buildDashboardCard(
                    title: 'Important Notes',
                    icon: Icons.note_alt_outlined,
                    color: const Color(0xFF26B3CC),
                    onTap: () {


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ImportantNotesScreen(),
                        ),
                      );


                    },
                  ),
                  _buildDashboardCard(
                    title: 'View Reports',
                    icon: Icons.bar_chart_outlined,
                    color: const Color(0xFF223832),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  AttendanceDetailScreen(),
                        ),
                      );


                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build consistent dashboard menu cards
  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}