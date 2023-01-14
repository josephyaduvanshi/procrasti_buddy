import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/services/notifiers/appointments_notifier.dart';
import 'package:procrasti_buddy/views/menu/pages/appointments/add_appointments.dart';
import 'package:procrasti_buddy/widgets/common_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../widgets/empty_tasks_journals_bills.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppointmentsNotifier(context),
      child: Consumer(
          builder: (context, AppointmentsNotifier appointmentsNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: "Appointments".text.make(),
            actions: [
              IconButton(
                onPressed: () {
                  appointmentsNotifier.deleteAll();
                },
                icon: const Icon(Icons.delete_forever_rounded,
                    color: Colors.purple),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _getToAddPageRoute(context, appointmentsNotifier);
            },
            child: const Icon(Icons.add),
          ).p(15),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<int>(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    left: 6,
                    right: 6,
                  ),
                  children: {
                    0: 'All'.text.bold.isIntrinsic.make(),
                    1: 'By Date'.text.bold.isIntrinsic.make(),
                  },
                  groupValue: appointmentsNotifier.slidingvalue,
                  onValueChanged: appointmentsNotifier.slidingOnChanged,
                ),
              ).pOnly(top: 15, bottom: 8).px(30),
              if (appointmentsNotifier.slidingvalue == 1) ...[
                DatePicker(
                  DateTime.now(),
                  width: 70,
                  height: 100,
                  initialSelectedDate: DateTime.now(),
                  selectedTextColor: Colors.white,
                  selectionColor: Colors.purple,
                  dateTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  dayTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  monthTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  onDateChange: (date) {
                    appointmentsNotifier.filterAppointmentByDate(date);
                  },
                ).py(8),
                Visibility(
                  visible: appointmentsNotifier
                      .filteredAppointmentsByDate.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, appointmentsNotifier);
                    },
                    buttonTitle: "Add Appointments",
                    title: 'No Tasks 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: appointmentsNotifier
                          .filteredAppointmentsByDate.length,
                      itemBuilder: (context, index) {
                        return CommonCardWidget(
                          title: appointmentsNotifier
                              .filteredAppointmentsByDate[index]
                              .appointmentName,
                          description: appointmentsNotifier
                              .filteredAppointmentsByDate[index]
                              .appointmentDescription,
                          type: appointmentsNotifier
                              .filteredAppointmentsByDate[index]
                              .appointmentPriority,
                          date: appointmentsNotifier
                              .filteredAppointmentsByDate[index]
                              .appointmentDueDate,
                          onDismissed: () {
                            appointmentsNotifier.deleteAppointments(
                                index: index);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
              if (appointmentsNotifier.slidingvalue == 0) ...[
                Visibility(
                  visible: appointmentsNotifier.appointmentsList.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, appointmentsNotifier);
                    },
                    buttonTitle: "Add Appointments",
                    title: 'No Appointments 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: appointmentsNotifier.appointmentsList.length,
                      itemBuilder: (context, index) {
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
                            appointmentsNotifier.deleteAppointments(
                                index: index);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  void _getToAddPageRoute(
      BuildContext context, AppointmentsNotifier appointmentsNotifier) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAppointmentsWidget(
                  appointmentsNotifier: appointmentsNotifier,
                )));
  }
}
