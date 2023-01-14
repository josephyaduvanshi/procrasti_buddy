import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/views/menu/pages/tasks_page/add_task.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../services/notifiers/task_service.dart';
import '../../../../widgets/empty_tasks_journals_bills.dart';
import '../../../../widgets/task_card_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskCRUDNotifer(context),
      child: Consumer(builder: (context, TaskCRUDNotifer taskNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: "Tasks".text.make(),
            actions: [
              IconButton(
                onPressed: () {
                  taskNotifier.deleteAll();
                },
                icon: const Icon(Icons.delete_forever_rounded,
                    color: Colors.purple),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _getToAddPageRoute(context, taskNotifier);
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
                  groupValue: taskNotifier.slidingvalue,
                  onValueChanged: taskNotifier.slidingOnChanged,
                ),
              ).pOnly(top: 15, bottom: 8).px(30),
              if (taskNotifier.slidingvalue == 1) ...[
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
                    taskNotifier.filterTasksByDate(date);
                  },
                ).py(8),
                Visibility(
                  visible: taskNotifier.filteredTasksByDate.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, taskNotifier);
                    },
                    buttonTitle: "Add Tasks",
                    title: 'No Tasks 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskNotifier.filteredTasksByDate.length,
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          taskModel: taskNotifier.filteredTasksByDate[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
              if (taskNotifier.slidingvalue == 0) ...[
                Visibility(
                  visible: taskNotifier.tasks.isNotEmpty,
                  replacement: EmptyHolderWidget(
                    onTap: () {
                      _getToAddPageRoute(context, taskNotifier);
                    },
                    buttonTitle: "Add Tasks",
                    title: 'No Tasks 🥲 😞',
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskNotifier.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          taskModel: taskNotifier.tasks[index],
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
      BuildContext context, TaskCRUDNotifer taskCRUDNotifer) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTaskW(
                  taskNotifier: taskCRUDNotifer,
                )));
  }
}
