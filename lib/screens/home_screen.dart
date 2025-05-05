import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandooq/screens/home_content.dart';
import 'package:sandooq/widgets/drawer.dart';
import 'explore_screen.dart';

class HomeScreen extends StatelessWidget {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _screens = [
    HomeContent(),
    ExploreScreen(),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _screens[_selectedIndex.value],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: _selectedIndex.value,
            onTap: (index) => _selectedIndex.value = index,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
            ],
          )),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    GoogleFonts.workSans(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 6),
            Text(value,
                style: GoogleFonts.workSans(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
