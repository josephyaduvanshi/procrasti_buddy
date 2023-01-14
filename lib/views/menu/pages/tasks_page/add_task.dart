import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/task_service.dart';
import 'package:procrasti_buddy/utils/validators.dart';
import 'package:procrasti_buddy/widgets/choice_chips_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTaskW extends StatelessWidget {
  final TaskCRUDNotifer taskNotifier;
  const AddTaskW({
    Key? key,
    required this.taskNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Brightness.dark == context.theme.brightness;
    return Scaffold(
      appBar: AppBar(
        title: 'Add Task'.text.make(),
        elevation: 5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: taskNotifier.formKey,
          child: ListView(
            children: [
              "Title".text.bold.xl.make().pOnly(top: 10).px(15),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.name,
                controller: taskNotifier.titleTextEditingController,
                onSaved: (value) {
                  taskNotifier.titleTextEditingController.text = value!;
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
                  hintText: 'Enter Title of Task',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Description".text.bold.xl.make().pOnly(top: 10).px(12),
              TextFormField(
                maxLines: 3,
                autofocus: false,
                keyboardType: TextInputType.name,
                controller: taskNotifier.descriptionTextEditingController,
                onSaved: (value) {
                  taskNotifier.descriptionTextEditingController.text = value!;
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
                  hintText: 'Enter Description of Task',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Date & Time".text.bold.xl.make().pOnly(top: 10).px(12),
              TextFormField(
                autofocus: false,
                readOnly: true,
                onTap: () {
                  taskNotifier.dateTimePicker(context);
                },
                validator: Validators.dateValidator,
                controller: taskNotifier.dateTextEditingController,
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
                  hintText: 'Select Date of Task',
                  filled: true,
                  fillColor: !darkMode ? Colors.white : context.canvasColor,
                ),
              ).px(12).py(12).pOnly(top: 10),
              "Category".text.bold.xl.make().pOnly(top: 10).px(12),
              ChangeNotifierProvider.value(
                value: taskNotifier,
                child: Consumer(
                    builder: (context, TaskCRUDNotifer taskCRUDNotifer, child) {
                  return ChoiceWidgetCategories(
                    notfier: taskCRUDNotifer,
                  ).px(12);
                }),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: taskNotifier.addTask,
                child:
                    const Text('\t\t\t\t\t\t\t\t\tSave Task\t\t\t\t\t\t\t\t\t'),
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
