// screens/languages/languages_section.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagesSection extends StatelessWidget {
  final List<Map<String, dynamic>> languages;

  const LanguagesSection({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Languages',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildLanguageList(),
        ],
      ),
    );
  }

  Widget _buildLanguageList() {
    return Column(
      children: languages.map((lang) {
        final String name = lang['name'] ?? 'Unknown';
        final int proficiency = lang['proficiency'] is int
            ? lang['proficiency']
            : 0;
        final Color barColor = _getProficiencyColor(proficiency);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: proficiency / 100,
                backgroundColor: Colors.grey[700],
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 4),
              Text(
                '$proficiency%',
                style: GoogleFonts.poppins(fontSize: 12, color: barColor),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getProficiencyColor(int level) {
    if (level >= 90) return Colors.green;
    if (level >= 70) return Colors.blue;
    if (level >= 50) return Colors.orange;
    return Colors.red;
  }
}
