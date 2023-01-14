import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/pomodoro_notifier.dart';
import 'package:procrasti_buddy/widgets/common_card_widget.dart';
import 'package:provider/provider.dart';

class PomoDoroSessionsListWidgetDashBoard extends StatelessWidget {
  final PomoDoroModelNotifier pomoDoroNotifier;
  const PomoDoroSessionsListWidgetDashBoard(
      {Key? key, required this.pomoDoroNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PomoDoroModelNotifier(context: context),
      child: Consumer(builder:
          (context, PomoDoroModelNotifier pomoDoroModelNotifier, child) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pomoDoroModelNotifier.pomoDoroModels.length,
            itemBuilder: (context, index) {
              if (index > 2) return Container();
              return CommonCardWidget(
                title:
                    'Session: ${pomoDoroModelNotifier.pomoDoroModels[index].sessionTime} Minutes',
                description:
                    'Break: ${pomoDoroModelNotifier.pomoDoroModels[index].shortBreakTime} Minutes',
                type: '',
                date: pomoDoroModelNotifier.pomoDoroModels[index].date,
                onDismissed: () =>
                    pomoDoroNotifier.deletePomoDoroModel(index: index),
              );
            });
      }),
    );
  }
}
