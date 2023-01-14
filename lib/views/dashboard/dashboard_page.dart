import 'package:flutter/material.dart';
import 'package:procrasti_buddy/routes/route_names.dart';
import 'package:procrasti_buddy/services/notifiers/bill_and_payments_notifier.dart';
import 'package:procrasti_buddy/services/notifiers/pomodoro_notifier.dart';
import 'package:procrasti_buddy/views/dashboard/bill_payments_widget_dashboard.dart';
import 'package:procrasti_buddy/views/dashboard/dashboard_appointment_widget.dart';
import 'package:procrasti_buddy/views/dashboard/pomodoro_sessions_widget_dahboard.dart';
import 'package:procrasti_buddy/widgets/no_datavailable_dashboard.dart';
import 'package:procrasti_buddy/widgets/swiper_widget_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../gen/assets.gen.dart';
import '../../services/notifiers/appointments_notifier.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          "Procrasti Buddy".text.bold.xl2.make().p(8).px(7).shimmer(
                primaryColor: Colors.purple,
                duration: 5.seconds,
                secondaryColor: Colors.red,
              ),
          5.heightBox,
          const SwiperWidgetDashboard(),
          12.heightBox,
          const Divider(
            color: Colors.purple,
            thickness: 0.8,
          ).px(5).shimmer(
                primaryColor: Colors.purple,
                secondaryColor: Colors.red,
              ),
          "Today's Appointments".text.bold.xl2.make().p(8).px(7).shimmer(
                primaryColor: Colors.purple,
                duration: 5.seconds,
                secondaryColor: Colors.red,
              ),
          ChangeNotifierProvider(
            create: (context) => AppointmentsNotifier(context),
            child: Consumer(builder:
                (context, AppointmentsNotifier appointmentsNotifier, child) {
              return Visibility(
                visible: appointmentsNotifier.appointmentsList.isNotEmpty,
                replacement: NoDataAvailableDashboardWidget(
                  buttonTitle: 'Add Appointments',
                  title: "There are no appointments for today",
                  imageAsset: Assets.images.noData,
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteNames.addAppointment),
                ),
                child: AppointmentsListWidgetDashBoard(
                  appointmentNotifier: appointmentsNotifier,
                ),
              );
            }),
          ),
          12.heightBox,
          const Divider(
            color: Colors.purple,
            thickness: 0.8,
          ).px(5).shimmer(
                primaryColor: Colors.purple,
                secondaryColor: Colors.red,
              ),
          "Pomodoro Sessions".text.bold.xl2.make().p(8).px(7).shimmer(
                primaryColor: Colors.green,
                duration: 5.seconds,
                secondaryColor: Colors.blue,
              ),
          ChangeNotifierProvider(
            create: (context) => PomoDoroModelNotifier(context: context),
            child: Consumer(builder:
                (context, PomoDoroModelNotifier pomoDoroModelNotifier, child) {
              return Visibility(
                visible: pomoDoroModelNotifier.pomoDoroModels.isNotEmpty,
                replacement: NoDataAvailableDashboardWidget(
                  buttonTitle: 'Start Session',
                  title: "There are no sessions available.",
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteNames.pomodoroPage),
                  imageAsset: Assets.images.pomodoroEmpty,
                ),
                child: PomoDoroSessionsListWidgetDashBoard(
                  pomoDoroNotifier: pomoDoroModelNotifier,
                ),
              );
            }),
          ),
          12.heightBox,
          const Divider(
            color: Colors.purple,
            thickness: 0.8,
          ).px(5).shimmer(
                primaryColor: Colors.purple,
                secondaryColor: Colors.red,
              ),
          "Biils & Payments".text.bold.xl2.make().p(8).px(7),
          ChangeNotifierProvider(
            create: (context) => BillPaymentNotifier(context),
            child: Consumer(builder:
                (context, BillPaymentNotifier billPaymentNotifier, child) {
              return Visibility(
                visible: billPaymentNotifier.billPaymentsList.isNotEmpty,
                replacement: NoDataAvailableDashboardWidget(
                  buttonTitle: 'Add Bill & Payements',
                  title: "There are no scheduled Bills and Payments.",
                  onPressed: () => Navigator.pushNamed(
                      context, RouteNames.billsAndPaymentPage),
                  imageAsset: Assets.images.notes,
                ),
                child: BillPaymentsListWidgetDashBoard(
                  billPaymentsNotifier: billPaymentNotifier,
                ),
              );
            }),
          ),
          12.heightBox,
        ],
      ),
    );
  }
}
