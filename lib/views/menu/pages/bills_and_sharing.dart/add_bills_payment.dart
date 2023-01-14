import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/bill_and_payments_notifier.dart';
import 'package:procrasti_buddy/utils/validators.dart';
import 'package:procrasti_buddy/widgets/bill_payment_drop_down.dart';
import 'package:velocity_x/velocity_x.dart';

class AddBillPaymentWidget extends StatelessWidget {
  final BillPaymentNotifier billPaymentNotifier;
  const AddBillPaymentWidget({Key? key, required this.billPaymentNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Brightness.dark == context.theme.brightness;
    return Scaffold(
      appBar: AppBar(
        title: 'Add Bill || Payments'.text.make(),
        elevation: 5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: billPaymentNotifier.formKey,
          child: ListView(
            children: [
              "Title".text.bold.xl.make().pOnly(top: 10).px(15),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.name,
                controller: billPaymentNotifier.titleTextEditingController,
                onSaved: (value) {
                  billPaymentNotifier.titleTextEditingController.text = value!;
                },
                validator: Validators.titleValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  labelText: "Title",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: 'Enter Title of Bill || Payment',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Description".text.bold.xl.make().pOnly(top: 10).px(12),
              TextFormField(
                maxLines: 3,
                autofocus: false,
                keyboardType: TextInputType.name,
                controller:
                    billPaymentNotifier.descriptionTextEditingController,
                onSaved: (value) {
                  billPaymentNotifier.descriptionTextEditingController.text =
                      value!;
                },
                validator: Validators.descriptionValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  labelText: "Description",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: 'Enter Description of Bill || Payment',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Date & Time".text.bold.xl.make().pOnly(top: 10).px(12),
              TextFormField(
                autofocus: false,
                readOnly: true,
                onTap: () {
                  billPaymentNotifier.dateTimePicker(context);
                },
                controller: billPaymentNotifier.dateTextEditingController,
                validator: Validators.dateValidator,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  labelText: "Date & Time",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: 'Select Date of Bill || Payment',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Category".text.bold.xl.make().pOnly(top: 10).px(12),
              BillPaymentCategoryDropDownWidget(
                  billPaymentNotifier: billPaymentNotifier),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: billPaymentNotifier.addbillPayments,
                child: const Text(
                    '\t\t\t\t\t\t\t\t\tSave Bill || Payment\t\t\t\t\t\t\t\t\t'),
              ).pOnly(top: 10).centered(),
            ],
          )
              .box
              .topRounded(value: 20)
              .width(double.infinity)
              .topRounded(value: 20)
              .make()
              .pOnly(top: 20),
        ),
      ),
    );
  }
}
