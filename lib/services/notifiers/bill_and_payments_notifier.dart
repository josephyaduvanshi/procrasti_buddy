import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:procrasti_buddy/database/bills_and_payments/bills_and_payments_model.dart';
import 'package:procrasti_buddy/services/notifications/notifications_helper.dart';
import 'package:procrasti_buddy/utils/snackbar.dart';
import 'package:procrasti_buddy/utils/utils.dart';

class BillPaymentNotifier with ChangeNotifier {
  late Box<BillPaymentModel> _billPaymentsBox;
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
  final String _priority = ' Normal ';
  final bool _isMax = false;
  final bool _isMid = false;
  final bool _isLow = false;
  final bool _isNormal = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<BillPaymentModel> _filteredbillPaymentsByDate = [];
  BillPaymentNotifier(this.context) {
    _billPaymentsBox = Hive.box<BillPaymentModel>('billPayment');
  }

  TextEditingController get titleTextEditingController =>
      _titleTextEditingController;

  TextEditingController get descriptionTextEditingController =>
      _descriptionTextEditingController;

  TextEditingController get dateTextEditingController =>
      _dateTextEditingController;

  GlobalKey<FormState> get formKey => _formKey;

  List<BillPaymentModel> get filteredbillPaymentsByDate =>
      _filteredbillPaymentsByDate;
  List<String> get dropDownMenuItemsList => _dropDownMenuItemsList;

  String get date => _date;

  String get time => _time;
  String get selectedCategory => _selectedCategory;

  int? get slidingvalue => _slidingvalue;

  List<BillPaymentModel> get billPaymentsList =>
      _billPaymentsBox.values.toList();

  List<BillPaymentModel> get billPaymentsListByPriority {
    return _billPaymentsBox.values.where((element) {
      return element.billPaymentPriority == _priority;
    }).toList();
  }

  void slidingOnChanged(int? value) {
    _slidingvalue = value;
    filterbillPaymentsByDate(DateTime.now());
    notifyListeners();
  }

  filterbillPaymentsByDate(value) {
    _filteredbillPaymentsByDate = _billPaymentsBox.values.where((element) {
      var taskDate =
          DateFormat("yyyy-MM-dd").parse(element.billPaymentDueDate.toString());
      var selectedDate = DateFormat("yyyy-MM-dd").parse(value.toString());
      return taskDate.compareTo(selectedDate) == 0;
    }).toList();
    notifyListeners();
  }

  dateTimePicker(BuildContext context) async {
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

  final List<String> _dropDownMenuItemsList = <String>[
    'Rent/Mortgage',
    'Utilities',
    'Internet/Cable/Phone',
    'Insurance',
    'Credit Card',
    'Loan Repayments',
    'Car Payment',
    'Groceries',
    'Medical Expenses',
    'Entertainment',
    'Travel',
    'Personal Care',
    'Education',
    'Charitable Contributions',
    'Pet Care',
    'Home Maintenance',
    'Clothing/Shopping',
    'Gym/Fitness',
    'Professional Services'
  ];
  String _selectedCategory = 'None';

  void changeSelectedCategory(String? value) {
    _selectedCategory = value!;
    notifyListeners();
  }

  void addbillPayments() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BillPaymentModel billPaymentModel = BillPaymentModel(
        billPaymentTitle: _titleTextEditingController.text,
        billPaymentDesc: _descriptionTextEditingController.text,
        billPaymentDueDate: Utilities.getDateTime(
            dateTimeString: _dateTextEditingController.text),
        billPaymentPriority: _selectedCategory,
      );
      _billPaymentsBox.add(billPaymentModel);
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
          message: "Bill || Payments Added Successfully");
      Navigator.pop(context);
    } else {
      ShowSnackBar.materialSnackbar(
          context: context,
          title: "Invalid Input",
          type: ContentType.failure,
          message: "Please fill all the fields");
    }
  }

  void updatebillPayments(
      {required BillPaymentModel billPaymentModel, required int index}) {
    _billPaymentsBox.putAt(index, billPaymentModel);
    notifyListeners();
  }

  void deletebillPayments({required int index}) {
    _billPaymentsBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _billPaymentsBox.deleteAll(_billPaymentsBox.keys);
    notifyListeners();
  }

  List<BillPaymentModel> getAllTasks() {
    return _billPaymentsBox.values.toList();
  }

  BillPaymentModel? getTaskById(int id) {
    return _billPaymentsBox.get(id);
  }
}
