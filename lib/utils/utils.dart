import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class Utilities {
  static String getRandomId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static DateTime getDateTime({
    required String dateTimeString,
  }) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime dateTimeObject = dateFormat.parse(dateTimeString);
    return dateTimeObject;
  }
}

extension DateUtils on DateTime {
  String get onlyTime {
    return "${this.toString().toDateString()}, ${year.toString()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} ${hour < 12 ? "AM" : "PM"}";
  }

  String get getOnlyTime {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} ${hour < 12 ? "AM" : "PM"}";
  }
}
