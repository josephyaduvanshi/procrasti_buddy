import 'package:hive/hive.dart';

part 'bills_and_payments_model.g.dart';

@HiveType(typeId: 3)
class BillPaymentModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String billPaymentTitle;

  @HiveField(2)
  final String billPaymentDesc;

  @HiveField(3)
  final DateTime billPaymentDueDate;

  @HiveField(4)
  final String? billPaymentPriority;

  @HiveField(5)
  final bool? isCompleted;

  BillPaymentModel(
      {this.id,
      this.isCompleted,
      required this.billPaymentTitle,
      required this.billPaymentDesc,
      required this.billPaymentDueDate,
      required this.billPaymentPriority});
}
