import 'package:flutter/material.dart';

class ChildProfileScreen extends StatefulWidget {
  const ChildProfileScreen({super.key});

  @override
  State<ChildProfileScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ChildProfileScreen> {
  // State variables for academic report dropdowns
  String _selectedYear = '2026';
  String _selectedExamType = 'Quarterly Exam';
  bool _reportSubmitted = false;

  // State variables for attendance filters
  String _selectedAttendanceMonth = 'June';
  String _selectedAttendanceYear = '2026';

  final List _academicResults = [
    {'subject': 'Maths', 'grade': '92 %'},
    {'subject': 'Physics', 'grade': '83 %'},
    {'subject': 'Chemistry', 'grade': '78 %'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF141E46),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {},
          ),
          title: const Text(
            'Rohan Krishna',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Attendance'),
              Tab(text: 'Homework'),
              Tab(text: 'Exams'),
              Tab(text: 'Progress'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. OVERVIEW TAB: Contains ALL details combined
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 24),
                  _buildAttendanceSection(),
                  const SizedBox(height: 24),
                  _buildHomeworkSection(),
                  const SizedBox(height: 24),
                  _buildExamsSection(),
                  const SizedBox(height: 24),
                  _buildAcademicReportsSection(),
                ],
              ),
            ),
            // 2. Attendance Tab
            SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: _buildAttendanceSection()),
            // 3. Homework Tab
            SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: _buildHomeworkSection()),
            // 4. Exams Tab
            SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: _buildExamsSection()),
            // 5. Progress Tab
            SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: _buildAcademicReportsSection()),
          ],
        ),
      ),
    );
  }

  // --- PROFILE CARD ---
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
            child: Icon(Icons.person, size: 45, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'Robin T P',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          const Text(
            '10th std',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          _buildInfoRow('Mobile number', '+91 9876543210'),
          const SizedBox(height: 8),
          _buildInfoRow('Parent', 'Radhika'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87))),
        const Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  // --- ATTENDANCE SECTION (With Month/Year & Absent/Late Dates) ---
  Widget _buildAttendanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Attendance Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Icon(Icons.visibility_outlined, color: Color(0xFF141E46)),
          ],
        ),
        const SizedBox(height: 12),
        // Month and Year Selection Dropdowns for Attendance
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCDDDE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAttendanceMonth,
                    isExpanded: true,
                    items: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
                        .map((String month) {
                      return DropdownMenuItem<String>(value: month, child: Text(month, style: const TextStyle(fontWeight: FontWeight.bold)));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAttendanceMonth = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCDDDE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAttendanceYear,
                    isExpanded: true,
                    items: ['2025', '2026', '2027'].map((String year) {
                      return DropdownMenuItem<String>(value: year, child: Text(year, style: const TextStyle(fontWeight: FontWeight.bold)));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAttendanceYear = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Attendance Stats Cards (Present, Absent, Late)
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Present',
                count: '24',
                color: Colors.teal,
                icon: Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard(
                title: 'Absent',
                count: '3',
                color: Colors.red,
                icon: Icons.cancel_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard(
                title: 'Late',
                count: '2',
                color: Colors.amber.shade800,
                icon: Icons.access_time_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Detailed Absent and Late Dates List Card
        Container(
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
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Logs for $_selectedAttendanceMonth $_selectedAttendanceYear',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF141E46)),
              ),
              const Divider(height: 20),
              _buildDateDetailRow(
                label: 'Absent Dates',
                dates: '15 June 2026, 24 June 2026, 29 June 2026',
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              _buildDateDetailRow(
                label: 'Late Dates',
                dates: '08 June 2026, 19 June 2026',
                color: Colors.amber.shade800,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDetailRow({required String label, required String dates, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            dates,
            style: const TextStyle(fontSize: 13, color: Colors.black ?? Colors.black87, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  // --- HOMEWORK SECTION ---
  Widget _buildHomeworkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Home Works',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFDCDDDE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '03-11-2026',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF141E46)),
              ),
              Icon(Icons.calendar_month_outlined, color: Colors.black87),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildHomeworkCard(
          title: 'Maths Equation Problem',
          description: 'Description : do the problems in page 1',
          status: 'Completed',
          statusColor: Colors.teal,
          dueDate: '27-12-2026',
        ),
        _buildHomeworkCard(
          title: 'Maths Equation Problem',
          description: 'Description : do the problems in page 1',
          status: 'Pending',
          statusColor: Colors.amber.shade800,
          dueDate: '27-12-2026',
        ),
        _buildHomeworkCard(
          title: 'Maths Equation Problem',
          description: 'Description : do the problems in page 1',
          status: 'Overdue',
          statusColor: Colors.red.shade700,
          dueDate: '27-12-2026',
        ),
      ],
    );
  }

  Widget _buildHomeworkCard({
    required String title,
    required String description,
    required String status,
    required Color statusColor,
    required String dueDate,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.menu_book_outlined, size: 32, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Status : ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text(status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: statusColor)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Due date : $dueDate', style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UPCOMING EXAMS SECTION ---
  Widget _buildExamsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Exams',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        _buildExamCard(title: 'Maths Test', time: '27-12-2026 10:00 AM'),
        _buildExamCard(title: 'Science Test', time: '27-12-2026 10:00 AM'),
      ],
    );
  }

  Widget _buildExamCard({required String title, required String time}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.note_alt_outlined, size: 32, color: Colors.black87),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 4),
              Text('From : $time', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // --- ACADEMIC PROGRESS SECTION ---
  Widget _buildAcademicReportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Academic Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCDDDE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedYear,
                    isExpanded: true,
                    items: ['2025', '2026', '2027'].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedYear = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCDDDE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedExamType,
                    isExpanded: true,
                    items: ['Quarterly Exam', 'Half Yearly Exam', 'Annual Exam'].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedExamType = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141E46),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              setState(() {
                _reportSubmitted = true;
              });
            },
            child: const Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
          ),
          child: Table(
            border: TableBorder.all(color: Colors.black87),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFDCDDDE)),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ],
              ),
              ..._academicResults.map((result) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(result['subject']!, style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(result['grade']!, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}