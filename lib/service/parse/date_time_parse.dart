String toHourMinute(DateTime time) {
  if (time.minute < 10) {
    return time.hour.toString() + ":0" + time.minute.toString();
  }
  return time.hour.toString() + ":" + time.minute.toString();
}

String toTimeFrame(DateTime startTime, DateTime endTime) {
  if (startTime != null) {
    if (endTime != null) {
      return toHourMinute(startTime) + " - " + toHourMinute(endTime);
    }
    return toHourMinute(startTime);
  }
  return "";
}

DateTime toDate(DateTime dateTime) {
  return dateTime != null
      ? new DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0)
      : dateTime;
}

String toDay(DateTime date) {
  return date?.day.toString();
}

String toWeekDay(DateTime date) {
  final toStr = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  return toStr[date.weekday - 1];
}

String toMonth(DateTime date) {
  final toStr = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return toStr[date.month - 1];
}
