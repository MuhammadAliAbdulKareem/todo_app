import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get dateFormatter {
    DateFormat formatter = DateFormat.yMMMMd('en_US');
    return formatter.format(this);
  }

  String get hoursFormatter {
    DateFormat formatter = DateFormat.jm('en_US');
    return formatter.format(this);
  }

  String get dayFormatter {
    DateFormat formatter = DateFormat.d('en_US');
    return formatter.format(this);
  }

  String get weekDayFormatter {
    DateFormat formatter = DateFormat.E('en_US');
    return formatter.format(this);
  }
}
