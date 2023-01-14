import 'package:hive/hive.dart';

part 'pomodoro_model_hive.g.dart';

@HiveType(typeId: 1)
class PomodoroHiveModel extends HiveObject {
  @HiveField(0)
  int sessionTime = 25;
  @HiveField(1)
  int shortBreakTime = 5;
  @HiveField(5)
  DateTime date = DateTime.now();

  PomodoroHiveModel({
    required this.sessionTime,
    required this.shortBreakTime,
    required this.date,
  });
}
