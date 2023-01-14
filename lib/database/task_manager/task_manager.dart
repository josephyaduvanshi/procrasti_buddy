import 'package:hive/hive.dart';

part 'task_manager.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String? type;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final bool? isCompleted;

  TaskModel({
    required this.title,
    this.isCompleted,
    required this.type,
    this.id,
    required this.description,
    required this.date,
  });
}
