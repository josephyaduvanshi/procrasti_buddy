import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 0)
class AppointmentModel {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String appointmentName;

  @HiveField(2)
  final String appointmentDescription;

  @HiveField(3)
  final DateTime appointmentDueDate;

  @HiveField(4)
  final int appointmentPriority;

  AppointmentModel(
      {required this.key,
      required this.appointmentName,
      required this.appointmentDescription,
      required this.appointmentDueDate,
      required this.appointmentPriority});
}
