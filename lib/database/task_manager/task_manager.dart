import 'package:hive/hive.dart';


part 'task_manager.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String taskName;

  @HiveField(2)
  final String taskDescription;

  @HiveField(3)
  final DateTime taskDueDate;

  @HiveField(4)
  final int taskPriority;

  @HiveField(5)
  final bool? isCompleted;

  Task({
    this.id ,
    this.isCompleted,
    required this.taskName,
    required this.taskDescription,
    required this.taskDueDate,
    required this.taskPriority,
  });
}
