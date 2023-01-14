import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrasti_buddy/database/appointments/appointment_model.dart';
import 'package:procrasti_buddy/database/bills_and_payments/bills_and_payments_model.dart';

import 'journal/journal_model.dart';
import 'pomodoro/pomodoro_model_hive.dart';
import 'task_manager/task_manager.dart';

class DatabaseConfig {
  static Future<void> initializeDatabase() async {
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(PomodoroHiveModelAdapter());
    Hive.registerAdapter(AppointmentModelAdapter());
    Hive.registerAdapter(BillPaymentModelAdapter());
    Hive.registerAdapter(JournalModelAdapter());
    await Hive.initFlutter();
    await Hive.openBox<TaskModel>('task');
    await Hive.openBox<JournalModel>('journal');
    await Hive.openBox<AppointmentModel>('appointments');
    await Hive.openBox<BillPaymentModel>('billPayment');
    await Hive.openBox<PomodoroHiveModel>('pomodoro');
  }
}
