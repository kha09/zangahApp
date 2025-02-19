class ScheduleResponse {
  final int totalPages;
  final int remainingDays;
  final int pagesPerDay;
  final List<ScheduleDay> schedule;
  final DateTime timestamp;

  ScheduleResponse({
    required this.totalPages,
    required this.remainingDays,
    required this.pagesPerDay,
    required this.schedule,
    required this.timestamp,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      totalPages: json['total_pages'],
      remainingDays: json['remaining_days'],
      pagesPerDay: json['pages_per_day'],
      schedule: (json['schedule'] as List)
          .map((day) => ScheduleDay.fromJson(day))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class ScheduleDay {
  final DateTime date;
  final PageRange pages;

  ScheduleDay({
    required this.date,
    required this.pages,
  });

  factory ScheduleDay.fromJson(Map<String, dynamic> json) {
    return ScheduleDay(
      date: DateTime.parse(json['date']),
      pages: PageRange.fromJson(json['pages']),
    );
  }
}

class PageRange {
  final int start;
  final int end;
  final int count;

  PageRange({
    required this.start,
    required this.end,
    required this.count,
  });

  factory PageRange.fromJson(Map<String, dynamic> json) {
    return PageRange(
      start: json['start'],
      end: json['end'],
      count: json['count'],
    );
  }
}
