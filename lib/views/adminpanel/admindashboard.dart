import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _activeSection = 'Dashboard';

  void _onTileTap(String title) {
    setState(() {
      _activeSection = title;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opened $title'),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'Admin panel',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2563EB)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Color(0xFF2563EB)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Admin Banner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 34,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'User Admin',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Teacher Section
            _buildSectionHeader('Teacher'),
            const SizedBox(height: 12),
            _buildTwoColumnGrid([
              _MenuTileData(
                label: 'Profile',
                icon: Icons.badge_outlined,
                color: const Color(0xFF2563EB),
              ),
              _MenuTileData(
                label: 'Work Hour',
                icon: Icons.access_time_outlined,
                color: const Color(0xFF0D9488),
              ),
              _MenuTileData(
                label: 'Create',
                icon: Icons.add_circle_outline,
                color: const Color(0xFF7C3AED),
              ),
              _MenuTileData(
                label: 'Exams',
                icon: Icons.assignment_outlined,
                color: const Color(0xFFD97706),
              ),
            ]),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(thickness: 1, color: Color(0xFFE2E8F0)),
            ),

            // Subjects & Classes Row[cite: 1]
            _buildTwoColumnGrid([
              _MenuTileData(
                label: 'Subjects',
                icon: Icons.menu_book_outlined,
                color: const Color(0xFF4F46E5),
              ),
              _MenuTileData(
                label: 'Classes',
                icon: Icons.class_outlined,
                color: const Color(0xFF059669),
              ),
            ]),

            const SizedBox(height: 24),

            // Students Section[cite: 1]
            _buildSectionHeader('Students'),
            const SizedBox(height: 12),
            _buildTwoColumnGrid([
              _MenuTileData(
                label: 'Profiles',
                icon: Icons.people_outline,
                color: const Color(0xFF2563EB),
              ),
              _MenuTileData(
                label: 'Home Work',
                icon: Icons.home_work_outlined,
                color: const Color(0xFFEA580C),
              ),
              _MenuTileData(
                label: 'Exam Results',
                icon: Icons.bar_chart_outlined,
                color: const Color(0xFF16A34A),
              ),
              _MenuTileData(
                label: 'Important Note',
                icon: Icons.sticky_note_2_outlined,
                color: const Color(0xFFDC2626),
              ),
              _MenuTileData(
                label: 'Attendance',
                icon: Icons.how_to_reg_outlined,
                color: const Color(0xFF0891B2),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 48,
          height: 2.5,
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildTwoColumnGrid(List<_MenuTileData> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = _activeSection == item.label;

        return InkWell(
          onTap: () => _onTileTap(item.label),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? item.color
                    : const Color(0xFFE2E8F0),
                width: isSelected ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuTileData {
  final String label;
  final IconData icon;
  final Color color;

  const _MenuTileData({
    required this.label,
    required this.icon,
    required this.color,
  });
}