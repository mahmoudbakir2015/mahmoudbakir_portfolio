// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(FontAwesomeIcons.github, githubUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.linkedin, linkedinUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.twitter, twitterUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.facebook, facebookUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.whatsapp, whatsappUrl),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await launchUrl(uri)) {
          // Successfully launched URL
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
    );
  }
}
