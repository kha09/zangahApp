import 'package:flutter/material.dart';
import 'study_plan_timeline.dart';
import 'study_options_screen.dart';
import 'summary_screen.dart';
import 'models/summary_model.dart';
import 'services/api_service.dart';

class SubjectDetailsWidget extends StatelessWidget {
  final String subject;
  final String semester;
  final VoidCallback onBack;

  const SubjectDetailsWidget({
    super.key,
    required this.subject,
    required this.semester,
    required this.onBack,
  });

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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionCard(
                context,
                'الملخص',
                onTap: () async {
                  try {
                    // Show loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    // Get summary from API
                    final summaryTexts = await ApiService.getSummary();
                    
                    // Create summary cards from the response
                    final summaryCards = summaryTexts.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      return SummaryCard(
                        title: 'نقطة $index',
                        content: entry.value,
                      );
                    }).toList();

                    // Pop loading dialog
                    Navigator.pop(context);

                    // Navigate to summary screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryScreen(summaryCards: summaryCards),
                      ),
                    );
                  } catch (e) {
                    // Pop loading dialog if showing
                    Navigator.pop(context);
                    
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('حدث خطأ: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              _buildOptionCard(
                context,
                'الاسئلة',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudyOptionsScreen(
                        subject: subject,
                        semester: semester,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Study Plan Timeline
        Expanded(
          child: StudyPlanTimeline(
            items: [
              StudyPlanItem(
                pageRange: 'من ص 12 إلى 87',
                date: '10/6',
                isCompleted: true,
                backgroundColor: Colors.yellow[100]!,
              ),
              StudyPlanItem(
                pageRange: 'من ص 89 إلى 143',
                date: '10/7',
                isCompleted: true,
                backgroundColor: Colors.blue[100]!,
              ),
              StudyPlanItem(
                pageRange: 'من ص 146 إلى 198',
                date: '10/8',
                isCompleted: false,
                backgroundColor: Colors.green[100]!,
              ),
              StudyPlanItem(
                pageRange: 'من ص 200 إلى 265',
                date: '10/9',
                isCompleted: false,
                backgroundColor: Colors.lightBlue[100]!,
              ),
              StudyPlanItem(
                pageRange: 'من ص 268 إلى 298',
                date: '10/10',
                isCompleted: false,
                backgroundColor: Colors.yellow[100]!,
              ),
            ],
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
        height: 100,
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
