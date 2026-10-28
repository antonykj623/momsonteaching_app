import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/teacher/studentlist.dart';
import 'package:momsonteaching_app/views/teacher/viewstudentattendance.dart';

import 'markattendance.dart';

class TeacherDashboard extends StatefulWidget {
   TeacherDashboard() ;

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {

  bool _isPasswordVisible = false;
  String _selectedAttendanceTab = 'Monthly';
  String _selectedClass = 'Class';
  String _selectedDivision = 'Division';
  String _selectedMonth = 'June 2026';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0F1B33);
    const oliveGreen = Color(0xFF334400); // or dark olive for button

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Moms on Teaching',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryNavy,
                    child: Icon(Icons.person, size: 45, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Greeshma T P',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '10 th std',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info Table / Rows
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  _buildInfoRow('Mobile number', '10th std'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Parent', 'Radhika'),
                  const SizedBox(height: 12),
                  _buildPasswordRow('Password', _isPasswordVisible ? 'Pass@123' : '********', () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown Filters Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedClass == 'Class' ? null : _selectedClass,
                        hint: const Text('Class', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        items: ['Class 9', 'Class 10'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedClass = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDivision == 'Division' ? null : _selectedDivision,
                        hint: const Text('Division', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        items: ['Division A', 'Division B'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDivision = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Attendance Section Title
            const Text(
              'Attendance',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Monthly / Daily Toggle Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton('Monthly', primaryNavy, const Color(0xFFB0B8C4), true),
                const SizedBox(width: 12),
                _buildTabButton('Daily', primaryNavy, const Color(0xFFB0B8C4), false),
              ],
            ),
            const SizedBox(height: 20),

            // Month Selector Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMonth,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  items: ['June 2026', 'July 2026', 'August 2026'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedMonth = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Circular Progress Indicator Container
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: CircularProgressIndicator(
                      value: 0.985,
                      strokeWidth: 22,
                      backgroundColor: const Color(0xFFC4C4C4),
                      valueColor: const AlwaysStoppedAnimation<Color>(primaryNavy),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  const Text(
                    '98.5 %',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Present / Absent Summary Labels
            const Text(
              'Present : 98.5 %',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            const Text(
              'Absent : 1.5 %',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 30),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  MarkAttendanceScreen(),
                    ),
                  );


                },
                child: const Text(
                  'Mark Attendance',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: oliveGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  StudentListScreen(),
                    ),
                  );


                },
                child: const Text(
                  'View Attendance',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const Text(':', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRow(String label, String value, VoidCallback onToggle) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const Text(':', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF0F1B33),
                  size: 20,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, Color activeColor, Color inactiveColor, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAttendanceTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: _selectedAttendanceTab == text ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedAttendanceTab == text ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
