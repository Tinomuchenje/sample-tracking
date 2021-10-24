class DateService {
  static String convertToIsoString(DateTime date) {
    return date.toIso8601String();
  }

  static String removeTime(DateTime date) {
    var dateTime = DateTime.parse(date.toString());

    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
}
