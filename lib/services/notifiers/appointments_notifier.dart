import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:procrasti_buddy/database/appointments/appointment_model.dart';
import 'package:intl/intl.dart';
import 'package:procrasti_buddy/services/notifications/notifications_helper.dart';
import 'package:procrasti_buddy/utils/snackbar.dart';
import 'package:procrasti_buddy/utils/utils.dart';

import '../../models/choice_chip_model.dart';

class AppointmentsNotifier with ChangeNotifier {
  late Box<AppointmentModel> _appointmentsBox;
  final BuildContext context;
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _dateTextEditingController =
      TextEditingController();
  int? _slidingvalue = 0;
  String _date = '';
  String _time = '';
  String _priority = ' Normal ';
  bool _isMax = false;
  bool _isMid = false;
  bool _isLow = false;
  bool _isNormal = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<AppointmentModel> _filteredAppointmentsByDate = [];
  AppointmentsNotifier(this.context) {
    _appointmentsBox = Hive.box<AppointmentModel>('appointments');
  }

  TextEditingController get titleTextEditingController =>
      _titleTextEditingController;

  TextEditingController get descriptionTextEditingController =>
      _descriptionTextEditingController;

  TextEditingController get dateTextEditingController =>
      _dateTextEditingController;

  GlobalKey<FormState> get formKey => _formKey;

  List<AppointmentModel> get filteredAppointmentsByDate =>
      _filteredAppointmentsByDate;

  String get date => _date;

  String get time => _time;

  int? get slidingvalue => _slidingvalue;

  List<AppointmentModel> get appointmentsList =>
      _appointmentsBox.values.toList();

  List<AppointmentModel> get appointmentsListByPriority {
    return _appointmentsBox.values.where((element) {
      return element.appointmentPriority == _priority;
    }).toList();
  }

  void slidingOnChanged(int? value) {
    _slidingvalue = value;
    filterAppointmentByDate(DateTime.now());
    notifyListeners();
  }

  filterAppointmentByDate(value) {
    _filteredAppointmentsByDate = _appointmentsBox.values.where((element) {
      var taskDate =
          DateFormat("yyyy-MM-dd").parse(element.appointmentDueDate.toString());
      var selectedDate = DateFormat("yyyy-MM-dd").parse(value.toString());
      return taskDate.compareTo(selectedDate) == 0;
    }).toList();
    notifyListeners();
  }

  dateTimePicker(BuildContext context) async {
    try {
      await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      ).then((value) {
        if (value != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(value);
          _date = formattedDate;
          notifyListeners();
        } else {}
      });
      // ignore: use_build_context_synchronously
      await timePicker(context);
    } catch (e) {
      print(e);
    }
  }

  timePicker(BuildContext context) async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        _time = value.format(context);
        _dateTextEditingController.text = '$_date $_time';
        print(_dateTextEditingController.text);
        notifyListeners();
      } else {}
    });
  }

  List<ChoiceChipModel> choiceChipList() {
    return [
      ChoiceChipModel(
        label: '\t\t\tMax\t\t\t',
        selected: _isMax,
        onSelected: (value) {
          _isMax = value;
          _isMid = false;
          _isNormal = false;
          _isLow = false;
          _priority = '\t\t\tMax\t\t\t';
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: '\t\t\tMid\t\t\t',
        selected: _isMid,
        onSelected: (value) {
          _isMax = false;
          _isMid = value;
          _isNormal = false;
          _isLow = false;
          _priority = '\t\t\tMid\t\t\t';
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: '\t\t\tLow\t\t\t',
        selected: _isLow,
        onSelected: (value) {
          _isMax = false;
          _isMid = false;
          _isNormal = false;
          _isLow = value;
          _priority = '\t\t\tLow\t\t\t';
          notifyListeners();
        },
      ),
      ChoiceChipModel(
        label: ' Normal ',
        selected: _isNormal,
        onSelected: (value) {
          _isMax = false;
          _isMid = false;
          _isNormal = value;
          _isLow = false;
          _priority = ' Normal ';
          notifyListeners();
        },
      ),
    ];
  }

  void resetChoiceChip() {
    _isMax = false;
    _isMid = false;
    _isNormal = false;
    _isLow = false;
    _priority = '';
  }

  void addAppointments() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      AppointmentModel appointmentModel = AppointmentModel(
        appointmentName: _titleTextEditingController.text,
        appointmentDescription: _descriptionTextEditingController.text,
        appointmentDueDate: Utilities.getDateTime(
            dateTimeString: _dateTextEditingController.text),
        appointmentPriority: _priority,
      );
      _appointmentsBox.add(appointmentModel);
      _titleTextEditingController.clear();
      _descriptionTextEditingController.clear();
      _dateTextEditingController.clear();
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
      notifyListeners();
      ShowSnackBar.materialSnackbar(
          context: context,
          title: "Success",
          type: ContentType.success,
          message: "Appointment Added Successfully");
      resetChoiceChip();
      Navigator.pop(context);
    } else {
      ShowSnackBar.materialSnackbar(
          context: context,
          title: "Invalid Input",
          type: ContentType.failure,
          message: "Please fill all the fields");
    }
  }

  void updateAppointments(
      {required AppointmentModel appointmentModel, required int index}) {
    _appointmentsBox.putAt(index, appointmentModel);
    notifyListeners();
  }

  void deleteAppointments({required int index}) {
    _appointmentsBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _appointmentsBox.deleteAll(_appointmentsBox.keys);
    notifyListeners();
  }

  List<AppointmentModel> getAllTasks() {
    return _appointmentsBox.values.toList();
  }

  AppointmentModel? getTaskById(int id) {
    return _appointmentsBox.get(id);
  }
}
