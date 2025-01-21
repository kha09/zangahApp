import 'package:flutter/material.dart';

class StudyOptionCard extends StatelessWidget {
  final String arabicText;
  final String englishText;
  final VoidCallback onTap;

  const StudyOptionCard({
    Key? key,
    required this.arabicText,
    required this.englishText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                arabicText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                englishText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyOptionsGrid extends StatelessWidget {
  const StudyOptionsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StudyOptionCard(
          arabicText: 'بطاقات تذكر',
          englishText: 'Flash Cards',
          onTap: () {
            // Handle flash cards tap
          },
        ),
        StudyOptionCard(
          arabicText: 'اختيار من متعدد',
          englishText: 'MCQ',
          onTap: () {
            // Handle MCQ tap
          },
        ),
      ],
    );
  }
}
