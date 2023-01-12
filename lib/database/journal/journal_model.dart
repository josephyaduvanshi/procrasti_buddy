import 'package:hive/hive.dart';

part 'journal_model.g.dart';

@HiveType(typeId: 2)
class JournalModel extends HiveObject {
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

  JournalModel({
    required this.title,
    required this.type,
    this.id,
    required this.description,
    required this.date,
  });
}
