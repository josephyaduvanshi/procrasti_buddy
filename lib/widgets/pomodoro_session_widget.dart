import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/pomodoro_notifier.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class PomodoroSessionWidget extends StatelessWidget {
  final PomoDoroModelNotifier pomodoroNotifier;
  const PomodoroSessionWidget({Key? key, required this.pomodoroNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: pomodoroNotifier.pomoDoroModels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: 'Session ${index + 1}'.text.lg.bold.make(),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Session: ${pomodoroNotifier.pomoDoroModels[index].sessionTime} Minutes'
                        .text
                        .bold
                        .make()
                        .py(3),
                    'Break: ${pomodoroNotifier.pomoDoroModels[index].shortBreakTime} Minutes'
                        .text
                        .bold
                        .make()
                        .py(3),
                    pomodoroNotifier.pomoDoroModels[index].date.onlyTime.text
                        .overflow(TextOverflow.ellipsis)
                        .make()
                        .py(3),
                    const Divider(
                      thickness: 0.8,
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: IconButton(
                  onPressed: () {
                    pomodoroNotifier.deletePomoDoroModel(index: index);
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              );
            }).px(12).py(5),
      ).px(6),
    );
  }
}
