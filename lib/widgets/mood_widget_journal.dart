import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/journal_notifier.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MoodJournalWidget extends StatelessWidget {
  const MoodJournalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JournalNotifier(context: context),
      child:
          Consumer(builder: (context, JournalNotifier journalNotifier, child) {
        return Row(
          children: [
            const SizedBox(width: 6),
            Expanded(
              child: ChoiceChip(
                label: "Happy".text.make(),
                selected: journalNotifier.choiceChipHappy,
                onSelected: journalNotifier.onSelectedchoiceChipHappy,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: ChoiceChip(
                label: "Sad".text.make(),
                selected: journalNotifier.choiceChipSad,
                onSelected: journalNotifier.onSelectedchoiceChipSad,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: ChoiceChip(
                label: "Angry".text.make(),
                selected: journalNotifier.choiceChipAngry,
                onSelected: journalNotifier.onSelectedchoiceChipAngry,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: ChoiceChip(
                label: "Anxious".text.make(),
                selected: journalNotifier.choiceChipAnxious,
                onSelected: journalNotifier.onSelectedchoiceChipAnxious,
              ),
            ),
          ],
        );
      }),
    );
  }
}
