import 'package:flutter/material.dart';


class StudentAttendance {
  final String name;
  bool isPresent;

  StudentAttendance({required this.name, required this.isPresent});
}

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String _selectedClass = 'Class';
  String _selectedDivision = 'Division';
  String _selectedMonth = 'June 2026';

  // Sample student list matching the design preview
  final List<StudentAttendance> _students = [
    StudentAttendance(name: 'Greeshma T P', isPresent: true),
    StudentAttendance(name: 'Robin Kurian', isPresent: false),
    StudentAttendance(name: 'Robin Kurian', isPresent: true),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0F1B33);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Mark Attendance',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Class and Division Dropdown Filters
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
                  const SizedBox(height: 16),

                  // Month Selector Dropdown (Full Width)
                  Container(
                    width: double.infinity,
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
                  const SizedBox(height: 20),

                  // Student List Cards with Interactive Checkmarks
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _students.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F5F3),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: primaryNavy,
                              child: Icon(Icons.person, size: 30, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                student.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // Interactive status indicator toggle (Tap to mark present/absent)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  student.isPresent = !student.isPresent;
                                });
                              },
                              child: student.isPresent
                                  ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(Icons.check, color: Colors.white, size: 18),
                              )
                                  : Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Submit Data Button at Bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
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
                  // Handle submission logic here
                },
                child: const Text(
                  'Submit Data',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}