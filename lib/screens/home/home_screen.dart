// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:mahmoudbakir_portfolio/screens/about/about_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/contact/contact_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/education/education.dart';
import 'package:mahmoudbakir_portfolio/screens/language/language_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/project_screen.dart';
import 'package:mahmoudbakir_portfolio/screens/skills/skills_screen.dart';
import 'package:mahmoudbakir_portfolio/utils/supbase_service.dart';
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
  final GlobalKey _languagesKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();

  // لعرض زر العودة للأعلى
  bool _showBackToTop = false;

  // البيانات المراد جلبها
  Map<String, dynamic>? userData;
  List<String> skills = [];
  List<Map<String, dynamic>> projects = [];
  List<Map<String, dynamic>> spokenLanguages = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadData(); // جلب البيانات عند التحميل
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
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

  // 🔽 جلب البيانات من Supabase
  Future<void> _loadData() async {
    try {
      // تأكد من تهيئة Supabase
      SupabaseService().initSupabase();

      // جلب بيانات المستخدم
      final user = await SupabaseService().getUserData();
      final userSkills = await SupabaseService().getSkills();
      final userProjects = await SupabaseService().getProjects();
      final userLanguages = await SupabaseService().getSpokenLanguages();

      if (mounted) {
        setState(() {
          userData = user;
          skills = userSkills;
          projects = userProjects;
          spokenLanguages = userLanguages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('فشل تحميل البيانات: $e')));
    }
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
          _isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      // صورة المستخدم
                      buildProfileImage(),

                      // الاسم
                      buildName(name: userData?['name'] ?? 'Loading...'),
                      SizedBox(height: 20),

                      // الوصف
                      buildProfession(
                        profession:
                            userData?['profession'] ??
                            'Flutter Developer & UI/UX Designer',
                      ),
                      SizedBox(height: 30),

                      // رموز التواصل الاجتماعي
                      buildSocialMedia(),
                      SizedBox(height: 40),

                      // قائمة التنقل
                      buildMobility(),
                      SizedBox(height: 40),

                      // الأقسام
                      Container(
                        key: _aboutKey,
                        child: AboutSection(bio: userData?['bio'] ?? ''),
                      ),
                      SizedBox(height: 40),
                      Container(
                        key: _educationKey,
                        child: EducationSection(
                          education: userData?['education'] ?? '',
                        ),
                      ),
                      SizedBox(height: 40),

                      Container(
                        key: _skillsKey,
                        child: SkillsSection(skills: skills),
                      ),
                      SizedBox(height: 40),
                      // ✅ قسم اللغات
                      Container(
                        key: _languagesKey,
                        child: LanguagesSection(
                          languages:
                              spokenLanguages, // مثل: [{'name': 'Arabic', 'proficiency': 95}, ...]
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        key: _projectsKey,
                        child: ProjectsSection(projects: projects),
                      ),
                      SizedBox(height: 40),

                      Container(
                        key: _contactKey,
                        child: ContactSection(userData: userData!),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),

          // زر العودة إلى الأعلى
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
    String? imageUrl = userData?['profile_image_url'];
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
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
          child: imageUrl == null
              ? Icon(Icons.person, size: 70, color: Colors.white)
              : null,
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
      spacing: 20,
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
      spacing: MediaQuery.of(context).size.width * 0.02,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton('About Me', _aboutKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        _buildNavButton('Education', _educationKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        _buildNavButton('Skills', _skillsKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        _buildNavButton('Languages', _languagesKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        _buildNavButton('Projects', _projectsKey),
        Icon(Icons.circle, size: 8, color: Colors.white),
        _buildNavButton('Contact', _contactKey),
      ],
    );
  }

  Widget _buildNavButton(String label, GlobalKey key) {
    return GestureDetector(
      onTap: () => _scrollTo(key),
      child: Text(
        label,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.025,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
