import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/parent/childprofile.dart';



class MomsonTeachingScreen extends StatefulWidget {
  const MomsonTeachingScreen({Key? key}) : super(key: key);

  @override
  State<MomsonTeachingScreen> createState() => _MomsonTeachingScreenState();
}

class _MomsonTeachingScreenState extends State<MomsonTeachingScreen> {
  int _selectedTabIndex = 0; // 0 for ROHAN, 1 for KRishna

  // Dummy student data with photo URLs
  final List _students = [
  {
  'name': 'ROHAN',
  'image': 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6',
  },
  {
  'name': 'Krishna',
  'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: const Color(0xFF004D61),
        title: const Text('Moms On Teaching - parent',style: TextStyle(fontSize: 14,color: Colors.white),),
        centerTitle: true,
        actions: [
          Padding(padding: EdgeInsets.all(5),child: IconButton(onPressed: (){


          }, icon: Icon(Icons.notifications,color: Colors.white,)),)


        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Wallpaper Section
            Container(
              margin: const EdgeInsets.all(16.0),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: const [
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Wallpaper',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Carousel Indicator Dots (...)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: index == 0 ? 12.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0 ? const Color(0xFF004D61) : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Tabs Section with Student Photos
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_students.length, (index) {
                  final isSelected = _selectedTabIndex == index;
                  final student = _students[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF004D61)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(student['image']!),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          student['name']!,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF004D61)
                                : Colors.black54,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Content Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     children: [
                       Expanded(child: Text(
                         'Name : ${_students[_selectedTabIndex]['name']} \n'
                             'Class : 3 \n'
                             'Division : B',
                         style: const TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                           color: Colors.grey,
                         ),
                       ),flex: 1,),
                       Expanded(child: Container(
                         child: TextButton(onPressed: (){

                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>  ChildProfileScreen(),
                             ),
                           );
                         }, child: Text("View Profile",style: TextStyle(fontSize: 12,color: Color(0xFF004D61)),)),




                       ),flex: 1,)
                     ],
                   ) ,



                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildFeatureCard(
                          icon: Icons.check_box_outlined,
                          title: 'Important Notes',
                          onTap: () {},
                        ),
                        _buildFeatureCard(
                          icon: Icons.menu_book_outlined,
                          title: 'Home Works',
                          onTap: () {},
                        ),
                        _buildFeatureCard(
                          icon: Icons.edit_note,
                          title: 'Exams',
                          onTap: () {},
                        ),
                        _buildFeatureCard(
                          icon: Icons.assignment_turned_in_outlined,
                          title: 'Attendance',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF004D61).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF9FBFC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF004D61)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}