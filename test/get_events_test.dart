import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/service/calendar/google_calendar_service.dart';
import 'package:student_utils_app/service/login/sign_in.dart';
import 'package:student_utils_app/service/parse/date_time_parse.dart';
import 'package:test/test.dart';

void main() {
  group('Get Events', () {
    test('Get events of 2 days, without calendarIds', () async {
      await signInWithGoogle(silently: true);
      final dateFrom = toDate(DateTime.now()).toUtc();
      final dateTo = toDate(DateTime.now().add(Duration(days: 1))).toUtc();

      var result = await getEvents(dateFrom, dateTo);

      expect(result, <String, List<CalendarEvent>>{
        toDate(DateTime.now()).toString():
            result[toDate(DateTime.now()).toString()],
        toDate(DateTime.now().add(Duration(days: 1))).toString():
            result[toDate(DateTime.now().add(Duration(days: 1)))]
      });
    });
    test('Get events of 2 days, with calendarIds', () async {
      await signInWithGoogle(silently: true);
      final dateFrom = toDate(DateTime.now()).toUtc();
      final dateTo = toDate(DateTime.now().add(Duration(days: 1))).toUtc();

      calendarIds = [
        "1cbjx1kbo2ib110c921u0c120",
        "3f3bygu23u4d3bh3kh4g32khb",
      ];

      var result = await getEvents(dateFrom, dateTo);

      expect(result, <String, List<CalendarEvent>>{
        toDate(DateTime.now()).toString():
            result[toDate(DateTime.now()).toString()],
        toDate(DateTime.now().add(Duration(days: 1))).toString():
            result[toDate(DateTime.now().add(Duration(days: 1)))]
      });
    });
  });
}
