import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String name;
  final Color color;

  Event(this.name, this.color);
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Sample event data
  final Map<DateTime, List<Event>> events = {
    DateTime(2024, 8, 25): [Event('Special Event', Colors.purple)],
    DateTime(2024, 8, 22): [Event('Schedule 2', Colors.lightBlue)],
    DateTime(2024, 8, 23): [
      Event('Schedule 1', Colors.blue),
      Event('Official Holiday', Colors.green)
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildCalendarHeader(),
            Expanded(
              child: _buildCalendarGrid(),
            ),
            _buildLegend(),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              // Add event functionality
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    final weekDays = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: weekDays
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 91, // 13 weeks * 7 days
      itemBuilder: (context, index) {
        return _buildCalendarCell(index);
      },
    );
  }

  Widget _buildCalendarCell(int index) {
    final date = DateTime(2024, 8, 22 + index);
    final dayEvents = events[date] ?? [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              DateFormat('M/d').format(date),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          if (dayEvents.isNotEmpty)
            Wrap(
              spacing: 4,
              children: dayEvents
                  .map((event) => Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: event.color,
                          shape: BoxShape.circle,
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLegendItem('جدول استذكاري - مادة 1', Colors.blue),
          _buildLegendItem('جدول استذكاري - مادة 2', Colors.lightBlue),
          _buildLegendItem('جدول استذكاري - مادة 3', Colors.red),
          _buildLegendItem('إجازات رسمية', Colors.green),
          _buildLegendItem('حدث مخصص', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
