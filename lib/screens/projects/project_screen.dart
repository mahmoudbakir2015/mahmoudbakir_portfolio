// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mahmoudbakir_portfolio/model/project_model.dart';

import 'package:mahmoudbakir_portfolio/screens/projects/project_card_widget.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects;
  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // ✅ استخدام Wrap لعرض جميع المشاريع بدون تمرير
          Wrap(
            spacing: 20, // المسافة بين العناصر أفقيًا
            runSpacing: 20, // المسافة بين العناصر رأسيًا
            children: projects.map((project) {
              return SizedBox(
                width: _getItemWidth(context), // عرض ديناميكي حسب الشاشة
                child: ProjectCard(project: ProjectModel.fromMap(project)),
              );
            }).toList(),
          ),

          const SizedBox(height: 40), // فراغ في النهاية
        ],
      ),
    );
  }

  // دالة لحساب عرض كل بطاقة حسب حجم الشاشة
  double _getItemWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 400; // شاشات كبيرة: 2 عمود
    if (width > 600) return (width - 60) / 2; // تابلت: 2 عمود
    return width; // جوال: عمود واحد
  }
}
