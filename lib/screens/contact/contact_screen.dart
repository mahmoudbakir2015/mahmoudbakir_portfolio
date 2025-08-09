// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء controllers للحصول على قيم الحقول
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    final TextEditingController messageController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'I\'m currently available for freelance work and open to new opportunities.',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildContactItem(
                    icon: Icons.email,
                    text: email,
                    onTap: () => _launchEmail(context),
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(
                    icon: Icons.phone,
                    text: phone,
                    onTap: () => _launchPhone(context),
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(
                    icon: Icons.location_on,
                    text: location,
                    onTap: () => _launchMap(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Follow Me',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(
                  icon: FontAwesomeIcons.github,
                  color: Colors.blue,
                  url: githubUrl,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: FontAwesomeIcons.linkedin,
                  color: Colors.blue[800]!,
                  url: linkedinUrl,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: FontAwesomeIcons.twitter,
                  color: Colors.blue[400]!,
                  url: twitterUrl,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.blue[600]!,
                  url: facebookUrl,
                ),
                const SizedBox(width: 20),
                _buildSocialButton(
                  icon: FontAwesomeIcons.whatsapp,
                  color: Colors.blue[600]!,
                  url: whatsappUrl,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Message',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your message here...',
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _sendEmail(
                          context: context,
                          nameController: nameController,
                          emailController: emailController,

                          messageController: messageController,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Send Message',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        await launchUrl(uri);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 5)],
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(emailLaunchUri);
  }

  Future<void> _launchPhone(BuildContext context) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(phoneLaunchUri);
  }

  Future<void> _launchMap(BuildContext context) async {
    final Uri mapLaunchUri = Uri(
      scheme: 'geo',
      path: '31.11346689346215, 30.950015057819382',
      // queryParameters: {'q': 'Cairo, Egypt'},
    );
    await launchUrl(mapLaunchUri);
  }

  void _sendEmail({
    required BuildContext context,
    String? subject,
    required TextEditingController nameController,
    required TextEditingController emailController,

    required TextEditingController messageController,
  }) {
    // التحقق من إدخال البيانات
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }
    final String name = nameController.text.trim();
    final String userEmail = emailController.text.trim();

    final String message = messageController.text.trim();
    // بناء الرسالة مع معلومات المرسل
    String emailBody =
        '''
Hello,

This is a message from my portfolio website.

Sender Name: $name
Sender Email: $userEmail

Subject: $subject

Message:
$message

Best regards,
$name (Portfolio Visitor)
''';

    // استبدال الأسطر الجديدة بـ %0A
    // إنشاء رابط البريد الإلكتروني
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mahmoudbakir2015@icloud.com',
      queryParameters: {
        'subject': subject ?? 'Contact from Portfolio',
        'body': emailBody,
      },
    );

    // فتح تطبيق البريد الإلكتروني
    launchUrl(emailLaunchUri).then((bool launched) {
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email client')),
        );
      } else {
        // مسح حقول النموذج بعد الإرسال
        nameController.clear();
        emailController.clear();

        messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email opened successfully!')),
        );
      }
    });
  }
}
