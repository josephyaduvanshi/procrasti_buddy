import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/pomodoro_notifier.dart';
import 'package:velocity_x/velocity_x.dart';

class PomodoroSettings extends StatelessWidget {
  final PomoDoroModelNotifier pomodoroNotifier;
  const PomodoroSettings({Key? key, required this.pomodoroNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          5.heightBox,
          "Session Time".text.lg.bold.make().pOnly(left: 21),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Slider(
            value: pomodoroNotifier.sessionTime.toDouble(),
            min: 1,
            max: 60,
            divisions: 59,
            label: pomodoroNotifier.sessionTime.toString(),
            onChanged: (value) {
              pomodoroNotifier.changeSessionTime(value.toInt());
            },
          ),
          "Break Time".text.lg.bold.make().pOnly(left: 21),
          Slider(
            value: pomodoroNotifier.shortBreakTime.toDouble(),
            min: 1,
            max: 60,
            divisions: 59,
            label: pomodoroNotifier.shortBreakTime.toString(),
            onChanged: (value) {
              pomodoroNotifier.changeShortBreakTime(value.toInt());
            },
          ),
        ],
      ),
    ).px(8);
  }
}
