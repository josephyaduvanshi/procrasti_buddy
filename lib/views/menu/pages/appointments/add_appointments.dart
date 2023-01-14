import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/appointments_notifier.dart';
import 'package:procrasti_buddy/utils/validators.dart';
import 'package:procrasti_buddy/widgets/choice_chips_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddAppointmentsWidget extends StatelessWidget {
  final AppointmentsNotifier appointmentsNotifier;
  const AddAppointmentsWidget({Key? key, required this.appointmentsNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Brightness.dark == context.theme.brightness;
    return Scaffold(
      appBar: AppBar(
        title: 'Add Appointments'.text.make(),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: appointmentsNotifier.formKey,
          child: ListView(
            children: [
              "Title".text.bold.xl.make().pOnly(top: 10).px(15),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.name,
                controller: appointmentsNotifier.titleTextEditingController,
                onSaved: (value) {
                  appointmentsNotifier.titleTextEditingController.text = value!;
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
                  hintText: 'Enter Title of Appointment',
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
                    appointmentsNotifier.descriptionTextEditingController,
                onSaved: (value) {
                  appointmentsNotifier.descriptionTextEditingController.text =
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
                  hintText: 'Enter Description of Appointment',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Date & Time".text.bold.xl.make().pOnly(top: 10).px(12),
              TextFormField(
                autofocus: false,
                readOnly: true,
                onTap: () {
                  appointmentsNotifier.dateTimePicker(context);
                },
                controller: appointmentsNotifier.dateTextEditingController,
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
                  hintText: 'Select Date of Appointment',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Priority".text.bold.xl.make().pOnly(top: 10).px(12),
              ChangeNotifierProvider(
                create: (context) => appointmentsNotifier,
                child: Consumer(
                  builder:
                      (context, AppointmentsNotifier appointmentsNotifier, _) =>
                          ChoiceWidgetCategories(
                    notfier: appointmentsNotifier,
                  ).px(12),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: appointmentsNotifier.addAppointments,
                child: const Text(
                    '\t\t\t\t\t\t\t\t\tSave Appointment\t\t\t\t\t\t\t\t\t'),
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
