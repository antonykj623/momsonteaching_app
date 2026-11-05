import 'package:flutter/material.dart';



class AddImportantNotesScreen extends StatefulWidget {
  const AddImportantNotesScreen({super.key});

  @override
  State<AddImportantNotesScreen> createState() => _AddImportantNotesScreenState();
}

class _AddImportantNotesScreenState extends State<AddImportantNotesScreen> {
  // Tab state: 0 for "Class wise", 1 for "Student wise"
  int _selectedTab = 0;

  // Form controllers and state
  String? _selectedClass;
  String? _selectedDivision;
  final TextEditingController _searchStudentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _searchStudentController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmitData() {
    // Handle form submission based on the active tab
    if (_selectedTab == 0) {
      debugShowSnackBar(
        'Submitted Class-wise Note: Class: $_selectedClass, Div: $_selectedDivision, Title: ${_titleController.text}',
      );
    } else {
      debugShowSnackBar(
        'Submitted Student-wise Note: Student: ${_searchStudentController.text}, Title: ${_titleController.text}',
      );
    }
  }

  void debugShowSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
          'Add important notes',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Class wise / Student wise Toggle Tabs
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? primaryNavy : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Class wise',
                          style: TextStyle(
                            color: _selectedTab == 0 ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? primaryNavy : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Student wise',
                          style: TextStyle(
                            color: _selectedTab == 1 ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Conditional Selection Fields based on Tab
            if (_selectedTab == 0) ...{
              // Class & Division Dropdowns
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedClass,
                          hint: const Text(
                            'Class',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                          items: ['Class 1', 'Class 2', 'Class 3']
                              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: (val) => setState(() => _selectedClass = val),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedDivision,
                          hint: const Text(
                            'Division',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                          items: ['Division A', 'Division B', 'Division C']
                              .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                              .toList(),
                          onChanged: (val) => setState(() => _selectedDivision = val),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            } else ...{
              // Student Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchStudentController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black),
                    hintText: 'search student',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
            },
            const SizedBox(height: 20),

            // Title TextField
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description TextField (Multi-line)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Submit Data Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _handleSubmitData,
                child: const Text(
                  'Submit Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}