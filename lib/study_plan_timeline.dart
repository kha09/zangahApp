import 'package:flutter/material.dart';

class StudyPlanItem {
  final String pageRange;
  final String date;
  final bool isCompleted;
  final Color backgroundColor;

  StudyPlanItem({
    required this.pageRange,
    required this.date,
    required this.isCompleted,
    required this.backgroundColor,
  });
}

class StudyPlanTimeline extends StatelessWidget {
  final List<StudyPlanItem> items;

  const StudyPlanTimeline({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                'الخطة الدراسية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return Row(
                textDirection: TextDirection.rtl,
                children: [
                  // Timeline
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.isCompleted ? Colors.green : Colors.grey[300],
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: item.isCompleted
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                      if (index < items.length - 1)
                        Container(
                          width: 2,
                          height: 60,
                          color: Colors.grey[300],
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Date
                  SizedBox(
                    width: 50,
                    child: Text(
                      item.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: item.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const Icon(Icons.description_outlined),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.pageRange,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('بدء'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
