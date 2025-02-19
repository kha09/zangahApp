import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/schedule_model.dart';
import 'services/schedule_service.dart';

// Event Model
class Event {
  final String name;
  final Color color;
  final String description;
  final DateTime date;
  final bool isScheduleEvent;
  final int? startPage;
  final int? endPage;

  Event(
    this.name,
    this.color,
    this.description,
    this.date, {
    this.isScheduleEvent = false,
    this.startPage,
    this.endPage,
  });

  factory Event.fromScheduleDay(ScheduleDay day) {
    return Event(
      'المراجعة اليومية',
      Colors.purple,
      'الصفحات ${day.pages.start} إلى ${day.pages.end}',
      day.date,
      isScheduleEvent: true,
      startPage: day.pages.start,
      endPage: day.pages.end,
    );
  }
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
  final VoidCallback? onTabSelected;
  
  const CalendarScreen({
    Key? key,
    this.onTabSelected,
  }) : super(key: key);

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  Map<DateTime, List<Event>> events = {};
  final ScheduleService _scheduleService = ScheduleService();

  @override
  void initState() {
    super.initState();
    loadSchedule();
  }

  Future<void> loadSchedule() async {
    try {
      print('Starting schedule load...'); // Debug print
      
      // Clear existing schedule events
      setState(() {
        events.clear();
      });
      
      final schedule = await _scheduleService.getSchedule();
      print('Schedule received, days: ${schedule.schedule.length}'); // Debug print
      
      setState(() {
        for (var day in schedule.schedule) {
          final date = DateTime(day.date.year, day.date.month, day.date.day);
          print('Processing day: ${date.toString()}, pages: ${day.pages.start}-${day.pages.end}'); // Debug print
          
          if (events[date] == null) {
            events[date] = [];
          }
          events[date]!.add(Event.fromScheduleDay(day));
        }
        print('Total events after update: ${_getAllEvents().length}'); // Debug print
      });
    } catch (e) {
      print('Error loading schedule: $e'); // Debug print
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تحميل الجدول: $e')),
        );
      }
    }
  }

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
    // Sort events by date
    allEvents.sort((a, b) => a.date.compareTo(b.date));
    return allEvents;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Calendar section (70% of height)
            SizedBox(
              height: constraints.maxHeight * 0.7,
              child: Column(
                children: [
                  // Month navigation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
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
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: loadSchedule,
                        ),
                      ],
                    ),
                  ),
                  _buildCalendarHeader(),
                  Expanded(
                    child: _buildCalendarGrid(),
                  ),
                ],
              ),
            ),
            // Events section (30% of height)
            Container(
              height: constraints.maxHeight * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: _buildLegend(),
              ),
            ),
          ],
        );
      },
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
      physics: const NeverScrollableScrollPhysics(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (events[date]?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Wrap(
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'الأحداث:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...allEvents.map((event) => _buildLegendItem(event)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Event event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: event.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  DateFormat('yyyy/MM/dd').format(event.date),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
