import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/database/journal/journal_model.dart';
import 'package:procrasti_buddy/utils/constants/constants.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:procrasti_buddy/views/menu/pages/journal_page/view_journal.dart';
import 'package:velocity_x/velocity_x.dart';

class JournalCardWidget extends StatelessWidget {
  final JournalModel journalModel;
  final String type;
  final int index;
  const JournalCardWidget({
    super.key,
    required this.index,
    required this.journalModel,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Constants.darkColors[Random().nextInt(17)]
            : Constants.lightColors[Random().nextInt(17)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: journalModel.title.text.bold
                .textStyle(GoogleFonts.lato())
                .color(const Color.fromARGB(194, 0, 0, 0))
                .scale(Constants.textScaleFactor(type))
                .maxLines(Constants.maxLines(type))
                .overflow(TextOverflow.ellipsis)
                .make()
                .pOnly(right: type == 'Horizontal' ? 102 : 0),
          ),
          const Divider(),
          Flexible(
            child: journalModel.description.text
                .textStyle(GoogleFonts.lato())
                .color(const Color.fromARGB(194, 0, 0, 0))
                .caption(context)
                .maxLines(Constants.maxLines(type))
                // .maxLines(6)
                .overflow(TextOverflow.ellipsis)
                .make(),
          ),
          const Spacer(),
          Flexible(
              child:
                  journalModel.date.onlyTime.text.bold.caption(context).make()),
          'Mood: ${Constants.getMoodType(journalModel.type)}'
              .text
              .caption(context)
              .make()
              .py(3),
        ],
      ),
    ).onTap(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JournalBriefInfo(
          journalModel: journalModel,
        );
      }));
    });
  }
}
