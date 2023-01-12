import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrasti_buddy/utils/constants/constants.dart';

import '../../utils/dialogs.dart';
import '../../database/pomodoro/pomodoro_model_hive.dart';

class PomoDoroModelNotifier extends ChangeNotifier {
  late Box<PomodoroHiveModel> _pomoDoroBox;
  final BuildContext context;
  CountDownController sessionController = CountDownController();
  bool isClockStarted = false;
  int sessionTime = 25 * 60;
  int shortBreakTime = 5 * 60;
  DateTime date = DateTime.now();
  IconData clockButton = Constants.playIcon;
  String text = 'Start';
  bool isBreak = false;

  void abortPomodoro() {
    sessionController.reset();
    notifyListeners();
  }

  void triggerStart() {
    if (sessionController.isRestarted) {
      log("TRIGGGGERED");
      sessionController.restart(duration: sessionTime);
      clockButton = Constants.pauseIcon;
      text = 'Pause';
      notifyListeners();
    }
    if (!sessionController.isStarted) {
      log("Session Start Fresh");
      sessionController.start();
      clockButton = Constants.pauseIcon;
      text = 'Pause';
      notifyListeners();
    } else if (sessionController.isPaused) {
      sessionController.resume();
      clockButton = Constants.pauseIcon;
      text = 'Pause';
      notifyListeners();
    } else {
      sessionController.pause();
      clockButton = Constants.playIcon;
      text = 'Resume';
      notifyListeners();
    }
  }

  void onCompleteSession() {
    if (sessionController.isRestarted) {
      log("Session Restarted OnComplete Triger");
      // abortPomodoro();
      triggerStart();
      notifyListeners();
    } else if (sessionController.isStarted) {
      log("Else Normal");
      clockButton = Constants.playIcon;
      text = 'Start';
      isClockStarted = false;
      addPomoDoroModel();
      DialogsProcrastiBudddy.showBreakRequest(
          context: context,
          onTapYes: () {
            isBreak = true;
            sessionController.restart(duration: shortBreakTime);
            notifyListeners();
            Navigator.pop(context);
          },
          onTapNo: () {
            isBreak = false;
            resetPomodoro();
            // abortPomodoro();
            notifyListeners();
            Navigator.pop(context);
          });
      notifyListeners();
    }
  }

  PomoDoroModelNotifier({required this.context}) {
    _pomoDoroBox = Hive.box<PomodoroHiveModel>('pomodoro');
  }

  List<PomodoroHiveModel> get pomoDoroModels => _pomoDoroBox.values.toList();

  Future<void> addPomoDoroModel() async {
    PomodoroHiveModel pomoDoroModel = PomodoroHiveModel(
      sessionTime: sessionTime,
      shortBreakTime: shortBreakTime,
      date: date,
    );
    await _pomoDoroBox.add(pomoDoroModel);
    notifyListeners();
  }

  Future<void> updatePomoDoroModel(
      {required PomodoroHiveModel pomoDoroModel, required int index}) async {
    await _pomoDoroBox.putAt(index, pomoDoroModel);
    notifyListeners();
  }

  Future<void> deletePomoDoroModel({required int index}) async {
    await _pomoDoroBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _pomoDoroBox.deleteAll(_pomoDoroBox.keys);
    notifyListeners();
  }

  void changeSessionTime(int value) {
    sessionTime = value;
    notifyListeners();
  }

  void changeShortBreakTime(int value) {
    shortBreakTime = value;
    notifyListeners();
  }

  void resetPomodoro() {
    sessionController.reset();
    clockButton = Constants.playIcon;
    text = 'Start';
    isClockStarted = false;
    sessionTime = sessionTime;
    shortBreakTime = shortBreakTime;
    date = DateTime.now();
    notifyListeners();
  }
}
