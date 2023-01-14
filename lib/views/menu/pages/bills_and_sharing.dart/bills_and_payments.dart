import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/services/notifiers/bill_and_payments_notifier.dart';
import 'package:procrasti_buddy/views/menu/pages/bills_and_sharing.dart/add_bills_payment.dart';
import 'package:procrasti_buddy/widgets/common_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../widgets/empty_tasks_journals_bills.dart';

class BillPaymentsPage extends StatelessWidget {
  const BillPaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BillPaymentNotifier(context),
      child: Consumer(
          builder: (context, BillPaymentNotifier billPaymentNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: "Bill & Payments".text.make(),
            actions: [
              IconButton(
                onPressed: () {
                  billPaymentNotifier.deleteAll();
                },
                icon: const Icon(Icons.delete_forever_rounded,
                    color: Colors.purple),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _getToAddPageRoute(context, billPaymentNotifier);
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
                  groupValue: billPaymentNotifier.slidingvalue,
                  onValueChanged: billPaymentNotifier.slidingOnChanged,
                ),
              ).pOnly(top: 15, bottom: 8).px(30),
              if (billPaymentNotifier.slidingvalue == 1) ...[
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
                  onDateChange: billPaymentNotifier.filterbillPaymentsByDate,
                ).py(8),
                Visibility(
                  visible:
                      billPaymentNotifier.filteredbillPaymentsByDate.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, billPaymentNotifier);
                    },
                    buttonTitle: "Add Bill and Payments",
                    title: 'No Bill and Payments 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          billPaymentNotifier.filteredbillPaymentsByDate.length,
                      itemBuilder: (context, index) {
                        return CommonCardWidget(
                          title: billPaymentNotifier
                              .filteredbillPaymentsByDate[index]
                              .billPaymentTitle,
                          description: billPaymentNotifier
                              .filteredbillPaymentsByDate[index]
                              .billPaymentDesc,
                          type: billPaymentNotifier
                              .filteredbillPaymentsByDate[index]
                              .billPaymentPriority!,
                          date: billPaymentNotifier
                              .filteredbillPaymentsByDate[index]
                              .billPaymentDueDate,
                          onDismissed: () {
                            billPaymentNotifier.deletebillPayments(
                                index: index);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
              if (billPaymentNotifier.slidingvalue == 0) ...[
                Visibility(
                  visible: billPaymentNotifier.billPaymentsList.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, billPaymentNotifier);
                    },
                    buttonTitle: "Add Bill and Payments",
                    title: 'No Bill and Payments 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: billPaymentNotifier.billPaymentsList.length,
                      itemBuilder: (context, index) {
                        return CommonCardWidget(
                          title: billPaymentNotifier
                              .billPaymentsList[index].billPaymentTitle,
                          description: billPaymentNotifier
                              .billPaymentsList[index].billPaymentDesc,
                          type: billPaymentNotifier
                              .billPaymentsList[index].billPaymentPriority!,
                          date: billPaymentNotifier
                              .billPaymentsList[index].billPaymentDueDate,
                          onDismissed: () {
                            billPaymentNotifier.deletebillPayments(
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
      BuildContext context, BillPaymentNotifier billPaymentNotifier) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddBillPaymentWidget(
                  billPaymentNotifier: billPaymentNotifier,
                )));
  }
}
