import 'package:velocity_x/velocity_x.dart';

class Utilities {
  static String getRandomId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

extension DateUtils on DateTime {
  String get onlyTime {
    return "${this.toString().toDateString()}, ${year.toString()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} ${hour < 12 ? "AM" : "PM"}";
  }
}
