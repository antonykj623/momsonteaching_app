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
  String _activeAcademicTab = 'Overview'; // Overview, Trends, Remarks

  // State variables for attendance filters
  String _selectedAttendanceMonth = 'June';
  String _selectedAttendanceYear = '2026';

  // Enhanced reactive tuition data including individual tests, weak topics, and teacher feedback
  final Map<String, dynamic> _tuitionData = {
    'Maths': {
      'grade': '92 %',
      'status': 'Excellent',
      'statusColor': Colors.green,
      'tests': [
        {'name': 'Test #1 (Algebra)', 'score': '88%'},
        {'name': 'Test #2 (Calculus Basics)', 'score': '95%'},
        {'name': 'Weekly Quiz #3', 'score': '93%'}
      ],
      'needsImprovement': 'Trigonometric Identities',
      'remarks': 'Exceptional problem-solving speed. Keep up the consistent homework discipline.'
    },
    'Physics': {
      'grade': '83 %',
      'status': 'Good',
      'statusColor': Colors.blue,
      'tests': [
        {'name': 'Test #1 (Mechanics)', 'score': '78%'},
        {'name': 'Test #2 (Kinematics)', 'score': '85%'},
        {'name': 'Weekly Quiz #3', 'score': '86%'}
      ],
      'needsImprovement': 'Electromagnetic Induction numericals',
      'remarks': 'Shows good grasp of concepts but needs more practice with vector diagrams.'
    },
    'Chemistry': {
      'grade': '78 %',
      'status': 'Needs Focus',
      'statusColor': Colors.orange,
      'tests': [
        {'name': 'Test #1 (Organic)', 'score': '72%'},
        {'name': 'Test #2 (Thermodynamics)', 'score': '80%'},
        {'name': 'Weekly Quiz #3', 'score': '82%'}
      ],
      'needsImprovement': 'Reaction Mechanisms & Balancing Equations',
      'remarks': 'Improving steadily after recent tutoring sessions on organic pathways.'
    },
  };

  // Expanded state for accordion dropdowns per subject
  final Map<String, bool> _expandedSubjects = {};

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
            style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
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

  // --- UPGRADED ACADEMIC PROGRESS SECTION ---
  Widget _buildAcademicReportsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Auto-Sync Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Academic Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF141E46)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.sync, size: 12, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Auto-Synced', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Filters Row (Year & Exam Type)
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedYear,
                      isExpanded: true,
                      items: ['2025', '2026', '2027'].map((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _selectedYear = newValue!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedExamType,
                      isExpanded: true,
                      items: ['Quarterly Exam', 'Half Yearly Exam', 'Annual Exam', 'Unit Tests (Live)'].map((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _selectedExamType = newValue!),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Sub-navigation Tabs (Scores vs Trends vs Remarks)
          Row(
            children: [
              _buildTabButton('Scores & Tests', 'Overview'),
              const SizedBox(width: 8),
              _buildTabButton('Trend Analysis', 'Trends'),
              const SizedBox(width: 8),
              _buildTabButton('Teacher Remarks', 'Remarks'),
            ],
          ),
          const SizedBox(height: 16),

          // Dynamic Content based on selected tab
          if (_activeAcademicTab == 'Overview') _buildScoresAndTestsList(),
          if (_activeAcademicTab == 'Trends') _buildTrendAnalysisView(),
          if (_activeAcademicTab == 'Remarks') _buildTeacherRemarksView(),

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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Academic report view refreshed successfully!')),
                );
              },
              child: const Text('Submit / Refresh', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, String tabKey) {
    bool isSelected = _activeAcademicTab == tabKey;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeAcademicTab = tabKey),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF141E46) : const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  // 1. Subject-wise Test Scores & Expandable Test Details
  Widget _buildScoresAndTestsList() {
    return Column(
      children: _tuitionData.entries.map((entry) {
        String subject = entry.key;
        var data = entry.value;
        bool isExpanded = _expandedSubjects[subject] ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('Status: ${data['status']}', style: TextStyle(color: data['statusColor'], fontSize: 12, fontWeight: FontWeight.w600)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141E46).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(data['grade'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF141E46))),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: Colors.grey),
                      onPressed: () => setState(() => _expandedSubjects[subject] = !isExpanded),
                    ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                const Divider(height: 1, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Individual Tuition Test Breakdown:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 6),
                      ...((data['tests'] as List).map((test) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('• ${test['name']}', style: const TextStyle(fontSize: 13)),
                            Text(test['score'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ))),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Needs Focus: ${data['needsImprovement']}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  // 2. Trend Analysis / Improvement Graph View
  Widget _buildTrendAnalysisView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Score Progression Over Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          const Text('Comparing Unit Test 1, Test 2, and Quarterly Exams', style: TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 16),
          // Visual Mock Graph Bars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTrendBar('Maths', 0.88, 0.95, 0.92, Colors.indigo),
              _buildTrendBar('Physics', 0.78, 0.85, 0.83, Colors.blue),
              _buildTrendBar('Chemistry', 0.72, 0.80, 0.78, Colors.teal),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.trending_up, size: 18, color: Colors.green),
              SizedBox(width: 6),
              Text('Overall growth: +6.4% improvement \n compared to last term.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendBar(String subject, double t1, double t2, double q, Color color) {
    return Column(
      children: [
        Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBarColumn('${(t1 * 100).toInt()}%', t1, color.withOpacity(0.4), 'T1'),
            const SizedBox(width: 4),
            _buildBarColumn('${(t2 * 100).toInt()}%', t2, color.withOpacity(0.7), 'T2'),
            const SizedBox(width: 4),
            _buildBarColumn('${(q * 100).toInt()}%', q, color, 'Q'),
          ],
        ),
      ],
    );
  }

  Widget _buildBarColumn(String label, double heightFactor, Color color, String testLabel) {
    return Column(
      children: [
        Container(
          width: 22,
          height: heightFactor * 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(testLabel, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  // 3. Teacher Remarks & Feedback View
  Widget _buildTeacherRemarksView() {
    return Column(
      children: _tuitionData.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF141E46))),
                  const Text('Tutor Feedback', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '"${entry.value['remarks']}"',
                style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}