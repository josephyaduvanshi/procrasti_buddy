import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/pomodoro_notifier.dart';
import 'package:procrasti_buddy/widgets/pomodoro_session_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PomoDoroModelNotifier(context: context),
        child: Consumer(
          builder: (context, PomoDoroModelNotifier pomodoroNotifier, child) {
            return Scaffold(
              appBar: AppBar(
                elevation: 5,
                title: "Pomodoro Clock".text.make(),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await pomodoroNotifier.deleteAll();
                      pomodoroNotifier.resetPomodoro();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ).disabled(pomodoroNotifier.sessionController.isStarted ||
                      pomodoroNotifier.sessionController.isRestarted),
                ],
              ),
              body: Column(
                children: [
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      CircularCountDownTimer(
                        controller: pomodoroNotifier.sessionController,
                        isReverseAnimation: true,
                        ringColor: const Color.fromARGB(255, 72, 94, 142),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                        autoStart: false,
                        duration: pomodoroNotifier.sessionTime * 60,
                        isReverse: true,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        fillColor: Colors.blue,
                        backgroundColor:
                            const Color.fromARGB(252, 121, 72, 143),
                        strokeCap: StrokeCap.round,
                        strokeWidth: 6.0,
                        onComplete: () {
                          pomodoroNotifier.onCompleteSession();
                        },
                      ).py(12).pOnly(top: 12),
                      10.heightBox,
                      ElevatedButton.icon(
                        onPressed: () {
                          pomodoroNotifier.triggerStart();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        icon: Icon(pomodoroNotifier.clockButton),
                        label: (pomodoroNotifier.text).text.make(),
                      ).px(12),
                    ],
                  ),
                  // 10.heightBox,
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: "Sessions: ${pomodoroNotifier.pomoDoroModels.length}"
                        .text
                        .xl
                        .bold
                        .color(Colors.purple)
                        .make()
                        .px(12)
                        .py(8),
                  ).py(2),
                  pomodoroNotifier.pomoDoroModels.isEmpty
                      ? const SizedBox()
                      : PomodoroSessionWidget(
                          pomodoroNotifier: pomodoroNotifier),
                ],
              ),
            );
          },
        ));
  }
}
