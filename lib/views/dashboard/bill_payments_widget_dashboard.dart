import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/bill_and_payments_notifier.dart';
import 'package:procrasti_buddy/widgets/common_card_widget.dart';
import 'package:provider/provider.dart';

class BillPaymentsListWidgetDashBoard extends StatelessWidget {
  final BillPaymentNotifier billPaymentsNotifier;
  const BillPaymentsListWidgetDashBoard({Key? key, required this.billPaymentsNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BillPaymentNotifier(context),
      child: Consumer(
          builder: (context, BillPaymentNotifier billPaymentNotifier, child) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: billPaymentNotifier.billPaymentsList.length,
            itemBuilder: (context, index) {
              if (index > 2) return Container();
              return CommonCardWidget(
                title: billPaymentNotifier
                    .billPaymentsList[index].billPaymentTitle,
                description:
                    billPaymentNotifier.billPaymentsList[index].billPaymentDesc,
                type: billPaymentNotifier
                    .billPaymentsList[index].billPaymentPriority!,
                date: billPaymentNotifier
                    .billPaymentsList[index].billPaymentDueDate,
                      onDismissed: () {
                  billPaymentsNotifier.deletebillPayments(index: index);
                },
              );
            });
      }),
    );
  }
}
