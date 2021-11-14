class DateService {
  static String convertToIsoString(DateTime date) {
    //converted to utc so that Iso can have trailing z(Format required by java.time.Instant)
    return date.toUtc().toIso8601String();
  }

  static String removeTime(DateTime date) {
    var dateTime = DateTime.parse(date.toString());

    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
}
