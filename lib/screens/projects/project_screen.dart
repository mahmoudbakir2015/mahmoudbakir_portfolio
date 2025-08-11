// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mahmoudbakir_portfolio/model/project_model.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/project_card_widget.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

  List<ProjectModel> projects = [
    ProjectModel(
      title: 'E-commerce App',
      description:
          'Full-featured e-commerce application with payment integration',
      image:
          'https://images.unsplash.com/photo-1551650975-87deedd944c3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'Firebase', 'Stripe'],
      githubUrl: 'https://github.com/example/ecommerce-app',
      liveUrl: 'https://example.com/ecommerce',
    ),
    ProjectModel(
      title: 'Task Management App',
      description: 'Productivity app for managing tasks and projects',
      image:
          'https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'Firestore', 'Provider'],
      githubUrl: 'https://github.com/example/task-manager',
      liveUrl: 'https://example.com/taskmanager',
    ),
    ProjectModel(
      title: 'Weather App',
      description: 'Real-time weather forecasting application',
      image:
          'https://images.unsplash.com/photo-1560072306-0329b3924a7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'OpenWeather API'],
      githubUrl: 'https://github.com/example/weather-app',
      liveUrl: 'https://example.com/weather',
    ),
    ProjectModel(
      title: 'Fitness Tracker',
      description: 'Health and fitness tracking application',
      image:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'Health API', 'Charts'],
      githubUrl: 'https://github.com/example/fitness-tracker',
      liveUrl: 'https://example.com/fitness',
    ),
    ProjectModel(
      title: 'Weather App',
      description: 'Real-time weather forecasting application',
      image:
          'https://images.unsplash.com/photo-1560072306-0329b3924a7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'OpenWeather API'],
      githubUrl: 'https://github.com/example/weather-app',
      liveUrl: 'https://example.com/weather',
    ),
    ProjectModel(
      title: 'Fitness Tracker',
      description: 'Health and fitness tracking application',
      image:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'Health API', 'Charts'],
      githubUrl: 'https://github.com/example/fitness-tracker',
      liveUrl: 'https://example.com/fitness',
    ),
    ProjectModel(
      title: 'Weather App',
      description: 'Real-time weather forecasting application',
      image:
          'https://images.unsplash.com/photo-1560072306-0329b3924a7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'OpenWeather API'],
      githubUrl: 'https://github.com/example/weather-app',
      liveUrl: 'https://example.com/weather',
    ),
    ProjectModel(
      title: 'Fitness Tracker',
      description: 'Health and fitness tracking application',
      image:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      technologies: ['Flutter', 'Health API', 'Charts'],
      githubUrl: 'https://github.com/example/fitness-tracker',
      liveUrl: 'https://example.com/fitness',
    ),
    // يمكنك إزالة التكرارات إن لم تكن مقصودة
  ];

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
                child: ProjectCard(project: project),
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
