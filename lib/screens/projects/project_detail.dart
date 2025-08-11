// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/const/string.dart';
import 'package:mahmoudbakir_portfolio/model/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // إزالة الـ AppBar العادي واستخدام واحد مخصص داخل الجسم
      body: Stack(
        children: [
          // الخلفية التدرجية (نفسها في HomeScreen)
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
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar مخصص (شفاف فوق الصورة)
                Stack(
                  children: [
                    // الصورة الكبيرة كخلفية للـ AppBar
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        child: Image.network(
                          project.mainImageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    // شريط التنقل (Back Button + Title)
                    Positioned(
                      top: 50,
                      left: 15,
                      right: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                project.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // المحتوى الرئيسي
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان
                      Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // الوصف
                      Text(
                        project.description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // تقنيات المشروع
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Technologies Used',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.technologies
                                  .map(
                                    (tech) => Chip(
                                      label: Text(
                                        tech,

                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor: Colors.blue.withOpacity(
                                        0.2,
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // تفاصيل إضافية
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Project Details',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              project.description,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                height: 1.6,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Key Features:',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '• Responsive design for all screen sizes\n• Modern UI/UX principles\n• Fast loading performance\n• Cross-platform compatibility\n• Clean and maintainable code structure',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                height: 1.6,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // زر عرض الكود
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            // GitHub action
                            final Uri uri = Uri.parse(project.githubUrl!);
                            await launchUrl(uri);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.code, size: 18),
                          label: Text(
                            'View Source Code',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // العناوين المشابهة
                      Text(
                        'Related Projects',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 120,
                              child: ProjectThumbnail(
                                galleryImageUrls:
                                    project.galleryImageUrls[index],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// مكون لعرض صورة صغيرة للمشاريع المرتبطة
// ignore: must_be_immutable
class ProjectThumbnail extends StatelessWidget {
  String galleryImageUrls;
  ProjectThumbnail({super.key, required this.galleryImageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(galleryImageUrls, fit: BoxFit.cover),
      ),
    );
  }
}
