// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSkillChip('Flutter', Colors.blue),
              _buildSkillChip('Dart', Colors.green),
              _buildSkillChip('Firebase', Colors.orange),
              _buildSkillChip('UI/UX Design', Colors.purple),
              _buildSkillChip('Responsive Design', Colors.red),
              _buildSkillChip('Git', Colors.grey),
              _buildSkillChip('Testing', Colors.indigo),
              _buildSkillChip('API Integration', Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
