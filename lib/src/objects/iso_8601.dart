/// Collection of methods for interacting with ISO 8601 data
class Iso8601 {
  /// Converts an ISO 8601 Duration string [duration] into a Duration object.
  ///
  /// Returns a valid Duration if the string can be parsed. Otherwise returns
  /// null.
  static Duration? parseDuration(String duration) {
    // ISO 8601 defines a duration as PnYnMnDTnHnMnS
    double years = 0;
    double months = 0;
    double weeks = 0;
    double days = 0;
    double hours = 0;
    double minutes = 0;
    double seconds = 0;
    String period;
    String? time;
    bool hasMatch = false;
    RegExp periodExp =
        RegExp(r"P([0-9.,]+Y)?([0-9.,]+M)?([0-9.,]+W)?([0-9.,]+D)?$");
    RegExp timeExp = RegExp(r"([0-9.,]+H)?([0-9.,]+M)?([0-9.,]+S)?$");
    RegExpMatch? match;

    // Split the duration between period and time
    List<String> splitTime = duration.split("T");
    period = splitTime[0];
    if (splitTime.length > 1) time = splitTime[1];

    match = periodExp.firstMatch(period);
    // If period didn't match and there was no time section in the string
    // then fail
    if (match != null) {
      hasMatch = true;
      // read the matches into associated fields
      years = _parseMatchToDouble(match.group(1));
      months = _parseMatchToDouble(match.group(2));
      weeks = _parseMatchToDouble(match.group(3));
      days = _parseMatchToDouble(match.group(4));
    }

    if (time != null) {
      match = timeExp.firstMatch(time);
      if (match != null) {
        hasMatch = true;
        hours = _parseMatchToDouble(match.group(1));
        minutes = _parseMatchToDouble(match.group(2));
        seconds = _parseMatchToDouble(match.group(3));
      }
    }

    if (hasMatch) {
      // Convert hours and minutes to seconds to account for decimal times
      minutes += hours * 60;
      seconds += minutes * 60;
      // Do the same for years -> days
      months += years * 12;
      weeks += months * 4;
      days += weeks * 7; // Yes I know it's off a little.
      return Duration(days: days.toInt(), seconds: seconds.toInt());
    } else {
      return null;
    }
  }

  /// Parses a regex map from an expected format into a double
  ///
  /// Expected format in regex is "[0-9,.]+X" where X can be anything
  static double _parseMatchToDouble(String? match) {
    if (match == null) {
      return 0;
    }
    int length = match.length - 1;
    match = match.replaceAll(',', '.');
    return double.parse(match.substring(0, length));
  }
}
