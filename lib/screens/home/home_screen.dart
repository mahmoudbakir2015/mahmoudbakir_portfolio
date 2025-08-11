// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:mahmoudbakir_portfolio/screens/about/about_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/contact/contact_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/project_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/skills/skills_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys للأقسام
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // لعرض زر العودة للأعلى
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // عرض/إخفاء زر العودة للأعلى فقط
    if (_scrollController.offset > 500 && !_showBackToTop) {
      setState(() {
        _showBackToTop = true;
      });
    } else if (_scrollController.offset <= 500 && _showBackToTop) {
      setState(() {
        _showBackToTop = false;
      });
    }
  }

  // دالة للتمرير إلى قسم معين
  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final position = context.findRenderObject() as RenderBox;
      final offset = position.localToGlobal(Offset.zero).dy;

      _scrollController.animateTo(
        offset - 60,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // العودة إلى الأعلى
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية التدرجية
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 50, 80, 76),
                  Color.fromARGB(255, 7, 7, 7),
                  Color.fromARGB(255, 59, 14, 11),
                ],
              ),
              image: DecorationImage(
                image: AssetImage(spider),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // المحتوى القابل للتمرير
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                // صورة المستخدم
                buildProfileImage(),

                // الاسم
                buildName(name: 'Mahmoud Bakir'),
                SizedBox(height: 20),

                // الوصف
                buildProfession(
                  profession: 'Flutter Developer & UI/UX Designer',
                ),
                SizedBox(height: 30),

                // رموز التواصل الاجتماعي
                buildSocialMedia(),
                SizedBox(height: 40),

                // قائمة التنقل (بدون مؤشر نشط)
                buildMobility(),
                SizedBox(height: 40),

                // الأقسام
                Container(key: _aboutKey, child: AboutSection()),
                SizedBox(height: 40),
                Container(key: _skillsKey, child: SkillsSection()),
                SizedBox(height: 40),
                Container(key: _projectsKey, child: ProjectsSection()),
                SizedBox(height: 40),
                Container(key: _contactKey, child: ContactSection()),
                SizedBox(height: 60),
              ],
            ),
          ),

          // زر العودة إلى الأعلى (يظهر عند التمرير لأسفل)
          if (_showBackToTop)
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Colors.white.withOpacity(0.9),
                elevation: 4,
                tooltip: 'Back to Top',
                child: Icon(Icons.arrow_upward, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  // دالة لعرض الصورة الاحترافية
  Widget buildProfileImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(0, 5),
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(
            'https://media.licdn.com/dms/image/v2/D4D03AQH2wY9Z8ZxQ2A/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1728381335263?e=1733356800&v=beta&t=6Y9Xa3W6Qv9hZJZ9qY0XZQZJZ9qY0XZQZJZ9qY0XZQ',
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.network(
                'https://media.licdn.com/dms/image/v2/D4D03AQH2wY9Z8ZxQ2A/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1728381335263?e=1733356800&v=beta&t=6Y9Xa3W6Qv9hZJZ9qY0XZQZJZ9qY0XZQZJZ9qY0XZQ',
                fit: BoxFit.cover,
                width: 136,
                height: 136,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[700],
                    child: Icon(Icons.person, size: 70, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName({required String name}) {
    return Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildProfession({required String profession}) {
    return Center(
      child: Text(
        profession,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Row buildSocialMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(FontAwesomeIcons.github, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(githubUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.linkedin, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(linkedinUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(facebookUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.telegram, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(telegramUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(whatsappUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(instagramUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.twitter, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(twitterUrl);
            await launchUrl(uri);
          },
        ),
        IconButton(
          icon: Icon(Icons.email_rounded, color: Colors.white),
          onPressed: () async {
            final Uri uri = Uri.parse(emailUrl);
            await launchUrl(uri);
          },
        ),
      ],
    );
  }

  Row buildMobility() {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // About Me
        _buildNavButton('About Me', _aboutKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        // Skills
        _buildNavButton('Skills', _skillsKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        // Projects
        _buildNavButton('Projects', _projectsKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        // Contact
        _buildNavButton('Contact', _contactKey),
      ],
    );
  }

  // زر بسيط بدون حالة نشطة
  Widget _buildNavButton(String label, GlobalKey key) {
    return GestureDetector(
      onTap: () => _scrollTo(key),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
