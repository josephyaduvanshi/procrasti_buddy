import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrasti_buddy/database/journal/journal_model.dart';
import 'package:procrasti_buddy/utils/snackbar.dart';

class JournalNotifier extends ChangeNotifier {
  late Box<JournalModel> _journalBox;
  bool choiceChipHappy = false;
  final BuildContext context;
  bool choiceChipSad = false;
  bool choiceChipAnxious = false;
  bool choiceChipAngry = false;
  String journalType = '';
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  JournalNotifier({required this.context}) {
    _journalBox = Hive.box<JournalModel>('journal');
  }

  List<JournalModel> get journalList => _journalBox.values.toList();

  void onSelectedchoiceChipHappy(bool value) {
    if (choiceChipSad || choiceChipAnxious || choiceChipAngry) {
      choiceChipSad = false;
      choiceChipAnxious = false;
      choiceChipAngry = false;
    }

    choiceChipHappy = value;
    journalType = 'Happy';
    notifyListeners();
  }

  void onSelectedchoiceChipSad(bool value) {
    if (choiceChipHappy || choiceChipAnxious || choiceChipAngry) {
      choiceChipHappy = false;
      choiceChipAnxious = false;
      choiceChipAngry = false;
    }
    choiceChipSad = value;
    journalType = 'Sad';
    notifyListeners();
  }

  void onSelectedchoiceChipAnxious(bool value) {
    if (choiceChipHappy || choiceChipSad || choiceChipAngry) {
      choiceChipHappy = false;
      choiceChipSad = false;
      choiceChipAngry = false;
    }
    choiceChipAnxious = value;
    journalType = 'Anxious';
    notifyListeners();
  }

  void onSelectedchoiceChipAngry(bool value) {
    if (choiceChipHappy || choiceChipSad || choiceChipAnxious) {
      choiceChipHappy = false;
      choiceChipSad = false;
      choiceChipAnxious = false;
    }
    choiceChipAngry = value;
    journalType = 'Angry';
    notifyListeners();
  }

  void resetChoiceChip() {
    choiceChipHappy = false;
    choiceChipSad = false;
    choiceChipAnxious = false;
    choiceChipAngry = false;
    journalType = '';
    notifyListeners();
  }

  void finalAddJournalToDb() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final journal = JournalModel(
        title: titleTextController.text,
        description: descriptionTextController.text,
        type: journalType,
        date: DateTime.now(),
      );
      addJournal(
        journal,
      );
      resetChoiceChip();
      titleTextController.clear();
      descriptionTextController.clear();
      notifyListeners();
      ShowSnackBar.materialSnackbar(
          context: context,
          title: "Success",
          type: ContentType.success,
          message: "Journal Added Successfully");
      Navigator.pop(context);
    } else {
      ShowSnackBar.materialSnackbar(
          context: context,
          title: "Invalid Input",
          type: ContentType.failure,
          message: "Please fill all the fields");
    }
  }

  Future<void> addJournal(JournalModel journal) async {
    await _journalBox.add(journal);
    notifyListeners();
  }

  Future<void> updateJournal(JournalModel journal, int index) async {
    await _journalBox.putAt(index, journal);
    notifyListeners();
  }

  Future<void> deleteJournal(int index) async {
    await _journalBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _journalBox.deleteAll(_journalBox.keys);
    notifyListeners();
  }
}
