import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedule_model.dart';

class ScheduleService {
  static const String baseUrl = 'http://localhost:3000';

  Future<ScheduleResponse> getSchedule() async {
    try {
      print('Making API request to: $baseUrl/organize');
      final response = await http.post(
        Uri.parse('$baseUrl/organize'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final scheduleResponse = ScheduleResponse.fromJson(jsonData);
        print('Schedule loaded with ${scheduleResponse.schedule.length} days');
        return scheduleResponse;
      } else {
        throw Exception('Failed to load schedule: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getSchedule: $e');
      rethrow;
    }
  }
}
