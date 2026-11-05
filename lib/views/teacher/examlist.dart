import 'package:flutter/material.dart';



class ExamModel {
  final String title;
  final String subject;
  final String year;
  final String className;
  final String division;
  final String date;

  ExamModel({
    required this.title,
    required this.subject,
    required this.year,
    required this.className,
    required this.division,
    required this.date,
  });
}

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  // Filter states
  String? _selectedYear;
  String? _selectedClass;
  String? _selectedDivision;

  // Master list of mock exams
  final List<ExamModel> _allExams = [
    ExamModel(
      title: 'Mid Term Assessment',
      subject: 'Mathematics',
      year: '2026',
      className: 'Class 10',
      division: 'Division A',
      date: '15-09-2026',
    ),
    ExamModel(
      title: 'Quarterly Examination',
      subject: 'Science & Tech',
      year: '2026',
      className: 'Class 10',
      division: 'Division B',
      date: '20-09-2026',
    ),
    ExamModel(
      title: 'Final Term Exam',
      subject: 'English Literature',
      year: '2025',
      className: 'Class 9',
      division: 'Division A',
      date: '10-12-2025',
    ),
    ExamModel(
      title: 'Unit Test 1',
      subject: 'Social Studies',
      year: '2026',
      className: 'Class 8',
      division: 'Division C',
      date: '05-04-2026',
    ),
  ];

  // Filter logic based on dropdown selections
  List<ExamModel> get _filteredExams {
    return _allExams.where((exam) {
      final matchesYear = _selectedYear == null || exam.year == _selectedYear;
      final matchesClass = _selectedClass == null || exam.className == _selectedClass;
      final matchesDivision = _selectedDivision == null || exam.division == _selectedDivision;
      return matchesYear && matchesClass && matchesDivision;
    }).toList();
  }

  void _clearFilters() {
    setState(() {
      _selectedYear = null;
      _selectedClass = null;
      _selectedDivision = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0F1B33);
    final displayedExams = _filteredExams;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Exam List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          if (_selectedYear != null || _selectedClass != null || _selectedDivision != null)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              tooltip: 'Reset Filters',
              onPressed: _clearFilters,
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter Container Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(
                  children: [
                    // Year Filter
                    Expanded(
                      child: _buildDropdown(
                        hint: 'Year',
                        value: _selectedYear,
                        items: ['2025', '2026', '2027'],
                        onChanged: (val) => setState(() => _selectedYear = val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Class Filter
                    Expanded(
                      child: _buildDropdown(
                        hint: 'Class',
                        value: _selectedClass,
                        items: ['Class 8', 'Class 9', 'Class 10'],
                        onChanged: (val) => setState(() => _selectedClass = val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Division Filter
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
              ],
            ),
          ),

          // Results Section
          Expanded(
            child: displayedExams.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    'No exams found for selected filters',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: displayedExams.length,
              itemBuilder: (context, index) {
                final exam = displayedExams[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5F4),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryNavy.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.assignment_outlined, size: 32, color: Color(0xFF0F1B33)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exam.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Subject: ${exam.subject}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${exam.className} \n ${exam.division}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Date: ${exam.date}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Reusable helper method for dropdown builder
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(fontSize: 13)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}