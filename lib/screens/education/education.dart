import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  final String education;
  const EducationSection({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            education,
            style: TextStyle(fontSize: 18, color: Colors.grey[300]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
