// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatelessWidget {
  final List<String> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    // قائمة الألوان الجذابة
    final List<Color> skillColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.deepOrange,
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/hexagon_background.png',
          ), // خلفية المثاقب السداسية
          fit: BoxFit.cover,
        ),
      ),
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
            children: skills.asMap().entries.map((entry) {
              int index = entry.key;
              String skill = entry.value;

              // اختيار لون بناءً على index (مع تكرار القائمة إذا زاد عدد المهارات)
              Color color = skillColors[index % skillColors.length];

              return Chip(
                label: _buildSkillChip(skill, color),
                backgroundColor: color.withOpacity(0.1),
                side: BorderSide(color: color.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // شكل دائري
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, Color color) {
    return Text(
      skill,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
