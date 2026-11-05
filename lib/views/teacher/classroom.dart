import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/teacher/examlist.dart';



class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({super.key});

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  // Action handler for the menu items
  void _onMenuTapped(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title tapped')),
    );

    if(title.compareTo("Exam List")==0)
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ExamListScreen(),
          ),
        );


      }


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
          'Class Room',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Classroom Banner Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Sessions Button Card
            _buildMenuCard(
              title: 'Sessions',
              icon: Icons.video_call_outlined,
              backgroundColor: const Color(0xFF26C6DA), // Cyan/Teal
              onTap: () => _onMenuTapped('Sessions'),
            ),
            const SizedBox(height: 16),

            // Exam List Button Card
            _buildMenuCard(
              title: 'Exam List',
              icon: Icons.assignment_outlined,
              backgroundColor: const Color(0xFF263238), // Dark Charcoal
              onTap: () => _onMenuTapped('Exam List'),
            ),
            const SizedBox(height: 16),

            // Mark List Button Card
            _buildMenuCard(
              title: 'Mark List',
              icon: Icons.check_circle_outline,
              backgroundColor: const Color(0xFF436850), // Muted Dark Green
              onTap: () => _onMenuTapped('Mark List'),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget builder for the menu items
  Widget _buildMenuCard({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Text(
                  '>>',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}