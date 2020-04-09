import 'package:googleapis/calendar/v3.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/service/parse/date_time_parse.dart';

Future<Map<String, List<CalendarEvent>>> initCalendar() {
  DateTime dateFrom = DateTime.now().toUtc().subtract(Duration(days: 7));
  DateTime dateTo = DateTime.now().toUtc().add(Duration(days: 14));
  return getEvents(dateFrom, dateTo);
}

Future<Map<String, List<CalendarEvent>>> getEvents(
    DateTime dateFrom, DateTime dateTo) async {
  while (calendarApi == null) {
    await new Future.delayed(const Duration(seconds: 5));
  }

  var calendarIds = [];

  var calendars = await calendarApi.calendarList.list();
  calendars.items.forEach((CalendarListEntry calendar) {
    if (!calendar.id.contains("@group.v.calendar.google.com")) {
      calendarIds.add(calendar.id);
    }
  });

  var futures = List<Future<Events>>();
  calendarIds.forEach((id) {
    futures.add(calendarApi.events
        .list(id, timeMin: dateFrom, timeMax: dateTo, singleEvents: true));
  });

  final Map<String, List<CalendarEvent>> update =
      <String, List<CalendarEvent>>{};
  initList(update, dateFrom, dateTo);
  var result = await Future.wait(futures);

  result.forEach((Events events) {
    parseCalendarEvents(events, update);
  });

  sortList(update);

  return update;
}

Map<String, List<CalendarEvent>> initList(
    Map<String, List<CalendarEvent>> init, DateTime dateFrom, DateTime dateTo) {
  for (int i = 0; i <= dateTo.difference(dateFrom).inDays; i++) {
    init[toDate(dateFrom.add(Duration(days: i)).toLocal()).toString()] =
        <CalendarEvent>[];
  }
  return init;
}

void parseCalendarEvents(
    Events events, Map<String, List<CalendarEvent>> updateList) {
  DateTime date;
  String calEvent;
  DateTime start;
  DateTime end;
  events.items.forEach((Event event) {
    date = toDate(event.start.date?.toLocal());
    if (date == null) {
      date = toDate(event.start.dateTime?.toLocal());
    }
    calEvent = event.summary;
    start = event.start.dateTime?.toLocal();
    end = event.end.dateTime?.toLocal();

    updateList.update(date.toString(), (list) {
      list.add(CalendarEvent(
        event: calEvent,
        startTime: start,
        endTime: end,
      ));
      return list;
    });
  });
}

void sortList(Map<String, List<CalendarEvent>> update) {
  update.forEach((key, list) {
    list.sort((elem1, elem2) {
      return elem1.startTime == null || elem2.startTime == null
          ? -1
          : elem1.startTime.isAfter(elem2.startTime)
          ? 1
          : elem1.startTime.isBefore(elem2.startTime) ? -1 : 0;
    });
  });
}
