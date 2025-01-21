import 'package:flutter/material.dart';

class SubjectDetailsWidget extends StatelessWidget {
  final String subject;
  final String semester;
  final VoidCallback onBack;

  const SubjectDetailsWidget({
    Key? key,
    required this.subject,
    required this.semester,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.cyan),
                onPressed: onBack,
              ),
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
        // Options
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionCard(
                  context,
                  'الملخص',
                  onTap: () {
                    // Handle summary tap
                  },
                ),
                _buildOptionCard(
                  context,
                  'الاسئلة',
                  onTap: () {
                    // Handle questions tap
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 200,
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
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}