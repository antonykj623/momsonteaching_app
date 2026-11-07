import 'package:flutter/material.dart';



class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  // Dropdown states
  String _selectedClass = 'Class';
  String _selectedDivision = 'Division';
  String _selectedDate = '26 June 2026';

  // State model for students' attendance tracking
  final List _students = [
  {
  'name': 'Greeshma T P',
  'attendance': 'P', // 'P', 'L', or 'A'
  'time1': '11:00 AM',
  'time2': '12:00 PM',
  },
  {
  'name': 'Greeshma T P',
  'attendance': 'L',
  'time1': '11:00 AM',
  'time2': '12:00 PM',
  },
  {
  'name': 'Greeshma T P',
  'attendance': 'A',
  'time1': '11:00 AM',
  'time2': '12:00 PM',
  },
  ];

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
          'Mark Attendance',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Class & Division Dropdowns Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedClass,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
                              items: ['Class', '10th Standard', '9th Standard'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedDivision,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
                              items: ['Division', 'Section A', 'Section B'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
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
                  const SizedBox(height: 12),

                  // Date Selection Dropdown/Pill
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDate,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
                        items: ['26 June 2026', '27 June 2026', '28 June 2026'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDate = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextButton(onPressed: (){}, child: Text("Mark all present",style: TextStyle(fontSize: 12),))
                 , const SizedBox(height: 16),

                  // List of Student Attendance Cards
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return _buildStudentCard(
                        name: student['name'],
                        attendance: student['attendance'],
                        time1: student['time1'],
                        time2: student['time2'],
                        onStatusChanged: (status) {
                          setState(() {
                            _students[index]['attendance'] = status;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Submit Button Area
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141E46),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Handle submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Attendance submitted successfully!')),
                  );
                },
                child: const Text(
                  'Submit Data',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build individual student attendance item card[cite: 6]
  Widget _buildStudentCard({
    required String name,
    required String attendance,
    required String time1,
    required String time2,
    required ValueChanged<String> onStatusChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Avatar
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF0D1B2A),
            child: Icon(Icons.person, size: 36, color: Colors.white),
          ),
          const SizedBox(width: 16),

          // Student details & Attendance status selectors
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildStatusButton('P', Colors.green.shade800, attendance == 'P', () => onStatusChanged('P')),
                    const SizedBox(width: 8),
                    _buildStatusButton('L', Colors.amber.shade900, attendance == 'L', () => onStatusChanged('L')),
                    const SizedBox(width: 8),
                    _buildStatusButton('A', Colors.red.shade700, attendance == 'A', () => onStatusChanged('A')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildTimeChip(time1),
                    const SizedBox(width: 10),
                    _buildTimeChip(time2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for status toggle choice buttons (P, L, A)[cite: 6]
  Widget _buildStatusButton(String label, Color activeColor, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.grey.shade600,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  // Helper widget for time slot labels[cite: 6]
  Widget _buildTimeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDDDE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        time,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}