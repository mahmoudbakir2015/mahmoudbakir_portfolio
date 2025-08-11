// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
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
}
