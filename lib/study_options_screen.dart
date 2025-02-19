import 'package:flutter/material.dart';
import 'mcq_screen.dart';
import 'study_options_grid.dart';

class StudyOptionsScreen extends StatelessWidget {
  final String subject;
  final String semester;

  const StudyOptionsScreen({
    super.key,
    required this.subject,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/mainpic.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              '$subject - $semester',
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: StudyOptionsGrid(),
      ),
    );
  }
}
