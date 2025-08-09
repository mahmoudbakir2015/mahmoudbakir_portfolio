import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmoudbakir_portfolio/model/project_model.dart';
import 'package:mahmoudbakir_portfolio/screens/projects/project_card_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Projects',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Click on any project to see details',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
