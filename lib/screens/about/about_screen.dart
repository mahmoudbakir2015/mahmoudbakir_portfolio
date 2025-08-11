import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            'I am a passionate Flutter developer and UI/UX designer with experience in building beautiful and responsive applications. I love turning ideas into reality.',
            style: TextStyle(fontSize: 18, color: Colors.grey[300]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
