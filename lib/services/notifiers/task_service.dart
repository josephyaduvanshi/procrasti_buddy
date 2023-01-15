import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:procrasti_buddy/database/task_manager/task_manager.dart';
import 'package:procrasti_buddy/models/choice_chip_model.dart';
import 'package:procrasti_buddy/services/notifications/notifications_helper.dart';
import 'package:procrasti_buddy/utils/snackbar.dart';

import '../../utils/utils.dart';

class TaskCRUDNotifer with ChangeNotifier {
  final BuildContext context;
  late Box<TaskModel> _taskBox;
  final titleTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  int? slidingvalue = 0;
  String date = '';
  String time = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  void slidingOnChanged(int? value) {
    slidingvalue = value;
    filterTasksByDate(DateTime.now());
    notifyListeners();
  }

  void dateTimePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(value);
        date = formattedDate;
        notifyListeners();
      } else {}
    });
    // ignore: use_build_context_synchronously
    await timePicker(context);
  }

  timePicker(BuildContext context) async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        time = value.format(context);
        dateTextEditingController.text = '$date $time';
        print(dateTextEditingController.text);
        notifyListeners();
      } else {}
    });
  }

  TaskCRUDNotifer(this.context) {
    _taskBox = Hive.box<TaskModel>('task');
  }

  String _category = 'None';

  bool isPersonalSelected = false;
  bool isWorkSelected = false;
  bool isProjectsSelected = false;
  bool isOthersSelected = false;

  List<ChoiceChipModel> choiceChipList() {
    return [
      ChoiceChipModel(
        label: 'Personal',
        selected: isPersonalSelected,
        onSelected: (value) {
          isPersonalSelected = value;
          isWorkSelected = false;
          isProjectsSelected = false;
          isOthersSelected = false;
          _category = 'Personal';
          log(_category);
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: 'Work',
        selected: isWorkSelected,
        onSelected: (value) {
          isPersonalSelected = false;
          isWorkSelected = value;
          isProjectsSelected = false;
          isOthersSelected = false;
          _category = 'Work';
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: 'Projects',
        selected: isProjectsSelected,
        onSelected: (value) {
          isPersonalSelected = false;
          isWorkSelected = false;
          isProjectsSelected = value;
          isOthersSelected = false;
          _category = 'Projects';
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: 'Others',
        selected: isOthersSelected,
        onSelected: (value) {
          isPersonalSelected = false;
          isWorkSelected = false;
          isProjectsSelected = false;
          isOthersSelected = value;
          _category = 'Others';
          notifyListeners();
        },
      ),
    ];
  }

  List<TaskModel> get tasks => _taskBox.values.toList();
  List<TaskModel> filteredTasksByDate = [];
  filterTasksByDate(value) {
    filteredTasksByDate = _taskBox.values.where((element) {
      var taskDate = DateFormat("yyyy-MM-dd").parse(element.date.toString());
      var selectedDate = DateFormat("yyyy-MM-dd").parse(value.toString());
      return taskDate.compareTo(selectedDate) == 0;
    }).toList();
    notifyListeners();
  }

  _reset() {
    isPersonalSelected = false;
    isWorkSelected = false;
    isProjectsSelected = false;
    isOthersSelected = false;
    _category = 'None';
    titleTextEditingController.clear();
    descriptionTextEditingController.clear();
    dateTextEditingController.clear();
    notifyListeners();
  }

  void addTask() async {
    print(_category);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TaskModel task = TaskModel(
          title: titleTextEditingController.text,
          description: descriptionTextEditingController.text,
          type: _category,
          date: Utilities.getDateTime(
              dateTimeString: dateTextEditingController.text),
          isCompleted: DateTime.now().isAfter(
            Utilities.getDateTime(
                dateTimeString: dateTextEditingController.text),
          ));
      _taskBox.add(task);
      filterTasksByDate(DateTime.now());
      // await NotificationService().requestIOSPermission();
      await NotificationApi.scheduleNotification(
        title: titleTextEditingController.text,
        desc: descriptionTextEditingController.text,
        scheduleDate: Utilities.getDateTime(
          dateTimeString: dateTextEditingController.text,
        ),
        time: Utilities.getDateTime(
          dateTimeString: dateTextEditingController.text,
        ).getOnlyTime,
      );
      // await NotificationService().scheduleNotification(
      //     title: titleTextEditingController.text,
      //     desc: descriptionTextEditingController.text,
      //     date: Utilities.getDateTime(
      //         dateTimeString: dateTextEditingController.text));
      _reset();
      notifyListeners();
      ShowSnackBar.materialSnackbar(
        context: context,
        type: ContentType.success,
        title: "Task Added",
        message: 'Task Added Successfully',
      );
      Navigator.pop(context);
    } else {
      ShowSnackBar.materialSnackbar(
        context: context,
        type: ContentType.failure,
        title: "Error",
        message: 'Please fill all the fields',
      );
    }
  }

  void updateTask({required TaskModel task, required int index}) {
    _taskBox.putAt(index, task);
    notifyListeners();
  }

  void deleteTask({required int index}) {
    _taskBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _taskBox.deleteAll(_taskBox.keys);
    tasks.clear();
    filteredTasksByDate.clear();
    notifyListeners();
  }

  List<TaskModel> getAllTasks() {
    return _taskBox.values.toList();
  }

  TaskModel? getTaskById(int id) {
    return _taskBox.get(id);
  }
}
