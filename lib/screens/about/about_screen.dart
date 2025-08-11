import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  final String bio;
  const AboutSection({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            bio,
            style: TextStyle(fontSize: 18, color: Colors.grey[300]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
