import 'package:flutter/material.dart';



enum AttendanceStatus { present, absent, late }

class StudentAttendanceModel {
  final String id;
  final String name;
  final String rollNo;
  AttendanceStatus status;

  StudentAttendanceModel({
    required this.id,
    required this.name,
    required this.rollNo,
    this.status = AttendanceStatus.present, // Default to Present
  });
}

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  // Filter States
  String? _selectedClass;
  String? _selectedDivision;
  DateTime _selectedDate = DateTime.now();
  bool _isSearched = false;

  // Student list
  List<StudentAttendanceModel> _students = [];

  // Getters to compute counts dynamically
  int get _presentCount => _students.where((s) => s.status == AttendanceStatus.present).length;
  int get _absentCount => _students.where((s) => s.status == AttendanceStatus.absent).length;
  int get _lateCount => _students.where((s) => s.status == AttendanceStatus.late).length;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  void _handleSearch() {
    if (_selectedClass == null || _selectedDivision == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both Class and Division')),
      );
      return;
    }

    setState(() {
      _isSearched = true;
      _students = [
        StudentAttendanceModel(id: '1', name: 'Alex Johnson', rollNo: '01', status: AttendanceStatus.present),
        StudentAttendanceModel(id: '2', name: 'Emma Watson', rollNo: '02', status: AttendanceStatus.present),
        StudentAttendanceModel(id: '3', name: 'Michael Smith', rollNo: '03', status: AttendanceStatus.absent),
        StudentAttendanceModel(id: '4', name: 'Sophia Davis', rollNo: '04', status: AttendanceStatus.late),
        StudentAttendanceModel(id: '5', name: 'Daniel Brown', rollNo: '05', status: AttendanceStatus.present),
      ];
    });
  }

  void _handleSubmitAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved! Present: $_presentCount, Absent: $_absentCount, Late: $_lateCount'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0F1B33);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Attendance Records',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        hint: 'Class',
                        value: _selectedClass,
                        items: ['Class 8', 'Class 9', 'Class 10'],
                        onChanged: (val) => setState(() => _selectedClass = val),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown(
                        hint: 'Division',
                        value: _selectedDivision,
                        items: ['Division A', 'Division B', 'Division C'],
                        onChanged: (val) => setState(() => _selectedDivision = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade400, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(_selectedDate),
                                style: const TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(Icons.calendar_today_outlined, color: Colors.black54, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryNavy,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: _handleSearch,
                          child: const Text(
                            'Search',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: !_isSearched
                ? Center(
              child: Text(
                'Please select filter parameters to view attendance data',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            )
                : Column(
              children: [
                // Summary Status Header Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryBadge('Present', _presentCount, Colors.green),
                      _buildSummaryBadge('Late', _lateCount, Colors.orange),
                      _buildSummaryBadge('Absent', _absentCount, Colors.red),
                    ],
                  ),
                ),

                // List of Students
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: primaryNavy.withOpacity(0.1),
                                child: Text(
                                  student.rollNo,
                                  style: const TextStyle(color: Color(0xFF0F1B33), fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    Text('Roll No: ${student.rollNo}', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                  ],
                                ),
                              ),
                              // Segmented Choice buttons for Present / Late / Absent
                              ToggleButtons(
                                isSel: [
                                  student.status == AttendanceStatus.present,
                                  student.status == AttendanceStatus.late,
                                  student.status == AttendanceStatus.absent,
                                ],
                                onPressed: (int idx) {
                                  setState(() {
                                    if (idx == 0) student.status = AttendanceStatus.present;
                                    if (idx == 1) student.status = AttendanceStatus.late;
                                    if (idx == 2) student.status = AttendanceStatus.absent;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Save Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _handleSubmitAttendance,
                      child: const Text(
                        'Save Attendance Data',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBadge(String label, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text('$label: $count', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Custom Toggle buttons helper widget for Present, Late, Absent
class ToggleButtons extends StatelessWidget {
  final List<bool> isSel;
  final ValueChanged<int> onPressed;

  const ToggleButtons({super.key, required this.isSel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildChoiceChip('P', Colors.green, isSel[0], () => onPressed(0)),
        const SizedBox(width: 4),
        _buildChoiceChip('L', Colors.orange, isSel[1], () => onPressed(1)),
        const SizedBox(width: 4),
        _buildChoiceChip('A', Colors.red, isSel[2], () => onPressed(2)),
      ],
    );
  }

  Widget _buildChoiceChip(String label, Color color, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}