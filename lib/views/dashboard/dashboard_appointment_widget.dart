import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/appointments_notifier.dart';
import 'package:procrasti_buddy/widgets/common_card_widget.dart';
import 'package:provider/provider.dart';

class AppointmentsListWidgetDashBoard extends StatelessWidget {
  final  AppointmentsNotifier appointmentNotifier;
  const AppointmentsListWidgetDashBoard({Key? key, required this.appointmentNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentsNotifier(context),
      child: Consumer(
          builder: (context, AppointmentsNotifier appointmentsNotifier, child) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appointmentsNotifier.appointmentsList.length,
            itemBuilder: (context, index) {
              if (index > 2) return Container();
              return CommonCardWidget(
                title: appointmentsNotifier
                    .appointmentsList[index].appointmentName,
                description: appointmentsNotifier
                    .appointmentsList[index].appointmentDescription,
                type: appointmentsNotifier
                    .appointmentsList[index].appointmentPriority,
                date: appointmentsNotifier
                    .appointmentsList[index].appointmentDueDate,
                onDismissed: () {
                  appointmentNotifier.deleteAppointments(index: index);
                },
              );
            });
      }),
    );
  }
}
