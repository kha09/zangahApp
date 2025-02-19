import 'package:flutter/material.dart';
import 'study_plan_timeline.dart';
import 'study_options_screen.dart';
import 'summary_screen.dart';
import 'models/summary_model.dart';
import 'models/schedule_model.dart';
import 'services/api_service.dart';
import 'services/schedule_service.dart';

class SubjectDetailsWidget extends StatefulWidget {
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
  State<SubjectDetailsWidget> createState() => _SubjectDetailsWidgetState();
}

class _SubjectDetailsWidgetState extends State<SubjectDetailsWidget> {
  final _scheduleService = ScheduleService();
  List<StudyPlanItem> _studyPlanItems = [];

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    try {
      final schedule = await _scheduleService.getSchedule();
      setState(() {
        _studyPlanItems = StudyPlanTimeline.fromSchedule(schedule);
      });
    } catch (e) {
      print('Error loading schedule: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تحميل الجدول: $e')),
        );
      }
    }
  }

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
                onPressed: widget.onBack,
              ),
              Image.asset(
                'assets/images/mainpic.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.subject} - ${widget.semester}',
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
                        subject: widget.subject,
                        semester: widget.semester,
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
            items: _studyPlanItems,
            onRefresh: _loadSchedule,
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
