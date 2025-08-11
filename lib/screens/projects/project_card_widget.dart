// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/model/project_model.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/project_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailScreen(project: project),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white, // خلفية بيضاء بدلاً من gradient
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المشروع
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                project.mainImageUrl!,
                fit: BoxFit.cover,
                height: 200, // ارتفاع الصورة
                width: double.infinity,
              ),
            ),

            // تفاصيل المشروع
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان المشروع
                  Text(
                    project.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // وصف المشروع
                  Text(
                    project.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  // تقنيات المشروع
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: project.technologies
                        .map(
                          (tech) => Chip(
                            label: Text(
                              tech,
                              style: GoogleFonts.poppins(fontSize: 10),
                            ),
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            labelStyle: const TextStyle(color: Colors.blue),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 10),

                  // زر "Code"
                  ElevatedButton.icon(
                    onPressed: () async {
                      // GitHub action
                      final Uri uri = Uri.parse(project.githubUrl!);
                      await launchUrl(uri);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      foregroundColor: const Color.fromARGB(255, 11, 16, 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: GoogleFonts.poppins(fontSize: 10),
                    ),
                    icon: const Icon(Icons.code, size: 12),
                    label: const Text('Code'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
