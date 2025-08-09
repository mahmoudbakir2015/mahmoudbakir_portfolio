import 'package:flutter/material.dart';
import 'package:mahmoudbakir_portfolio/screens/about/about_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/contact/contact_screen.dart';
import 'package:mahmoudbakir_portfolio/widgets/custom_app_bar.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/projects_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AboutScreen(),
    const ProjectsScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
            BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Contact'),
          ],
        ),
      ),
    );
  }
}
