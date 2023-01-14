import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/bill_and_payments_notifier.dart';
import 'package:velocity_x/velocity_x.dart';

class BillPaymentCategoryDropDownWidget extends StatelessWidget {
  final BillPaymentNotifier billPaymentNotifier;
  const BillPaymentCategoryDropDownWidget(
      {Key? key, required this.billPaymentNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        hintText: 'Select Category',
      ),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: billPaymentNotifier.changeSelectedCategory,
      items: billPaymentNotifier.dropDownMenuItemsList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: value.text.make(),
        );
      }).toList(),
    ).p(12).pOnly(bottom: 8, top: 5);
  }
}
