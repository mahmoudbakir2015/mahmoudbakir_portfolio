import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeSection extends StatelessWidget {
  final String cvUrl;
  const ResumeSection({super.key, required this.cvUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      color: Colors.grey.shade100, // لون خلفية خفيف يفرق عن الباقي
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "My Resume",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Download my CV to learn more about my experience, skills, and projects.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),

          // ✅ زرار تحميل CV
          ElevatedButton.icon(
            onPressed: () async {
              final Uri uri = Uri.parse(cvUrl);
              if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not open $uri');
              }
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              "Download CV",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
