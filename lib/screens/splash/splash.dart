// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:mahmoudbakir_portfolio/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد التحكم في التأثيرات
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // تأثير الشفافية
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // تأثير التمرير
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // تشغيل التأثيرات
    _controller.forward();

    // الانتقال إلى الصفحة الرئيسية بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية الديناميكية
          _buildBackground(),

          // المحتوى الرئيسي
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // شعار التطبيق
                    _buildLogo(),

                    const SizedBox(height: 30),

                    // اسم الشخص
                    Text(
                      'Mahmoud Bakir',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // المهنة
                    Text(
                      'Flutter Developer & UI/UX Designer',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // شريط التحميل
                    _buildLoadingIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // بناء الخلفية الديناميكية
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple, Colors.pink],
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(seconds: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.purple.withOpacity(0.3),
              Colors.pink.withOpacity(0.3),
            ],
          ),
        ),
      ),
    );
  }

  // بناء الشعار
  Widget _buildLogo() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple, Colors.pink],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Image(
          image: AssetImage(myPhoto),
          fit: BoxFit.cover, // هذا مهم لجعل الصورة تملأ الدائرة
        ),
      ),
    );
  }

  // بناء شريط التحميل
  Widget _buildLoadingIndicator() {
    return Container(
      width: 200,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
