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
        width: 200,
        height: 200,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.cyan,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  arabicText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  englishText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.cyan.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
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
      ),
    );
  }
}
