import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Event Model
class Event {
  final String name;
  final Color color;
  final String description;
  final DateTime date;

  Event(this.name, this.color, this.description, this.date);
}

// Event Creation Dialog
class AddEventDialog extends StatefulWidget {
  final DateTime selectedDate;

  const AddEventDialog({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Color _selectedColor = Colors.blue;

  final List<Color> _colors = [
    Colors.blue,
    Colors.lightBlue,
    Colors.red,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إضافة حدث جديد',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'اسم الحدث',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'وصف الحدث',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _colors
                  .map(
                    (color) => GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      Navigator.pop(
                        context,
                        Event(
                          _nameController.text,
                          _selectedColor,
                          _descriptionController.text,
                          widget.selectedDate,
                        ),
                      );
                    }
                  },
                  child: const Text('إضافة'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

// Event Details Dialog
class EventDetailsDialog extends StatelessWidget {
  final Event event;

  const EventDetailsDialog({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: event.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  event.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'التاريخ: ${DateFormat('yyyy/MM/dd').format(event.date)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  Map<DateTime, List<Event>> events = {};

  DateTime? get selectedDate => _selectedDate;

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });

    final dayEvents = events[selectedDay] ?? [];
    if (dayEvents.isNotEmpty) {
      _showEventDetails(dayEvents.first);
    }
  }

  Future<void> addEvent(DateTime date) async {
    final event = await showDialog<Event>(
      context: context,
      builder: (context) => AddEventDialog(selectedDate: date),
    );

    if (event != null) {
      setState(() {
        if (events[date] == null) {
          events[date] = [];
        }
        events[date]!.add(event);
      });
    }
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) => EventDetailsDialog(event: event),
    );
  }

  void _previousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
    });
  }

  List<Event> _getAllEvents() {
    final allEvents = <Event>[];
    events.forEach((date, eventList) {
      allEvents.addAll(eventList);
    });
    return allEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _previousMonth,
            ),
            Text(
              DateFormat('MMMM yyyy').format(_focusedDate),
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _nextMonth,
            ),
          ],
        ),
        _buildCalendarHeader(),
        Expanded(
          child: _buildCalendarGrid(),
        ),
        _buildLegend(),
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
    final daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: (daysInMonth + firstWeekday + (7 - ((daysInMonth + firstWeekday) % 7)) % 7),
      itemBuilder: (context, index) {
        if (index < firstWeekday) {
          return Container();
        }

        final day = index - firstWeekday + 1;
        if (day > daysInMonth) {
          return Container();
        }

        final date = DateTime(_focusedDate.year, _focusedDate.month, day);
        final isSelected = _selectedDate?.year == date.year &&
            _selectedDate?.month == date.month &&
            _selectedDate?.day == date.day;

        return GestureDetector(
          onTap: () => _onDaySelected(date),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: isSelected ? Colors.blue.withOpacity(0.1) : null,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (events[date]?.isNotEmpty ?? false)
                  Wrap(
                    spacing: 4,
                    children: events[date]!
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
          ),
        );
      },
    );
  }

  Widget _buildLegend() {
    final allEvents = _getAllEvents();
    if (allEvents.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text(
          'لا توجد أحداث',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الأحداث:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...allEvents.map((event) => _buildLegendItem(event.name, event.color)),
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
