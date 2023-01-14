import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 4)
class AppointmentModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String appointmentName;

  @HiveField(2)
  final String appointmentDescription;

  @HiveField(3)
  final DateTime appointmentDueDate;

  @HiveField(4)
  final String appointmentPriority;

  @HiveField(5)
  final bool? isCompleted;

  AppointmentModel(
      {this.id,
      this.isCompleted,
      required this.appointmentName,
      required this.appointmentDescription,
      required this.appointmentDueDate,
      required this.appointmentPriority});
}
