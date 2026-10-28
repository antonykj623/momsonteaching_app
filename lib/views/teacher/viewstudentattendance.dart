import 'package:flutter/material.dart';



class ViewStudentScreen extends StatelessWidget {
  const ViewStudentScreen({super.key});

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
          'View Student',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Student Profile Card
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
                    'Robin T P',
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

            // Info Rows
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  _buildInfoRow('Mobile number', '10th std'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Parent', 'Radhika'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Attendance Section Header with visibility icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Attendance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const Icon(Icons.visibility, color: primaryNavy, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Calendar Card Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2ECE9),
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
                  const Text(
                    'June 2026',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryNavy),
                  ),
                  const SizedBox(height: 16),

                  // Days of the week headers
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('S', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('M', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('T', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('W', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('T', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('F', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('S', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Calendar Grid / Rows
                  _buildCalendarGrid(),

                  const SizedBox(height: 24),

                  // Total Absent Days Summary
                  const Text(
                    'Total Absent days : 3',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
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

  Widget _buildCalendarGrid() {
    // Exact layout representation matching June 2026 in the design screenshot
    final List<List<String?>> weeks = [
      [null, '1', '2', '3', '4', '5', '6'],
      ['7', '8', '9', '10', '11', '12', '13'],
      ['14', '15', '16', '17', '18', '19', '20'],
      ['21', '22', '23', '24', '25', '26', '27'],
      ['28', '29', '30', null, null, null, null],
    ];

    // Absent dates marked with red X in the design: 15, 24, 30
    final absentDays = ['15', '24', '30'];
    // Sundays (highlighted in red)
    final sundayDays = ['7', '14', '21', '28'];

    return Column(
      children: weeks.map((week) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: week.map((day) {
              if (day == null) {
                return const SizedBox(width: 30, height: 30);
              }

              bool isAbsent = absentDays.contains(day);
              bool isSunday = sundayDays.contains(day);

              return SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSunday ? Colors.red : Colors.black,
                      ),
                    ),
                    if (isAbsent)
                      const CustomPaint(
                        size: Size(26, 26),
                        painter: CrossPainter(),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

// Custom Painter to draw the red X marks over absent dates
class CrossPainter extends CustomPainter {
  const CrossPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}