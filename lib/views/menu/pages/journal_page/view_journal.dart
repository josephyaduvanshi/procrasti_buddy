import 'package:flutter/material.dart';
import 'package:procrasti_buddy/database/journal/journal_model.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/constants/constants.dart';

class JournalBriefInfo extends StatelessWidget {
  final JournalModel journalModel;
  const JournalBriefInfo({super.key, required this.journalModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Journal Overview'.text.make(),
        elevation: 5,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.edit),
        ),
      ),
      body: ListView(
        children: [
          journalModel.title.text
              .textStyle(Constants.titleTextStyle)
              .overflow(TextOverflow.ellipsis)
              .make()
              .scrollHorizontal(),
          const Divider(),
          6.heightBox,
          journalModel.date.onlyTime.text
              .caption(context)
              .textStyle(Constants.dateTextStyle)
              .make(),
          const Divider(
            thickness: 1,
          ),
          ChoiceChip(
            label:
                "${journalModel.type ?? "None"} ${Constants.getMoodType(journalModel.type)}"
                    .text
                    .make(),
            selected: true,
            onSelected: (value) {},
          ).box.alignCenterLeft.make(),
          // 'Mood:
          //     .text
          //     .bold
          //     .caption(context)
          //     .make(),
          journalModel.description.text
              .textStyle(Constants.descriptionTextStyle)
              .make(),
          40.heightBox,
        ],
      ).p(8).px(8),
    );
  }
}
