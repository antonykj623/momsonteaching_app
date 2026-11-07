import 'package:flutter/material.dart';

class ViewStudentScreen extends StatefulWidget {
  const ViewStudentScreen({super.key});

  @override
  State<ViewStudentScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ViewStudentScreen> {
  // State variables for academic report dropdowns
  String _selectedYear = '2026';
  String _selectedExamType = 'Quarterly Exam';
  bool _reportSubmitted = false;

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
            'View Student',
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

  // --- ATTENDANCE SECTION ---
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFECE9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'June 2026',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF141E46)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                    .map((day) => Text(day, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)))
                    .toList(),
              ),
              const SizedBox(height: 12),
              _buildCalendarGrid(),
              const SizedBox(height: 16),
              const Text(
                'Total Absent days : 3',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final List<String> days = [
      '31', '1', '2', '3', '4', '5', '6',
      '7', '8', '9', '10', '11', '12', '13',
      '14', '15*', '16', '17', '18', '19', '20',
      '21', '22', '23', '24*', '25', '26', '27',
      '28', '29*', '30', ''
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        String day = days[index];
        bool isAbsent = day.endsWith('*');
        if (isAbsent) day = day.replaceAll('*', '');

        if (day.isEmpty) return const SizedBox();

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isAbsent ? Colors.red.withOpacity(0.1) : Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isAbsent ? Colors.red : Colors.black87,
                ),
              ),
              if (isAbsent)
                const Icon(Icons.close, size: 22, color: Colors.red),
            ],
          ),
        );
      },
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