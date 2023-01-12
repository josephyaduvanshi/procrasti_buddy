import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';
import 'package:procrasti_buddy/services/notifiers/journal_notifier.dart';
import 'package:procrasti_buddy/widgets/journal_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/constants/constants.dart';
import 'add_journal.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JournalNotifier(context: context),
      child:
          Consumer(builder: (context, JournalNotifier journalNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: "Journal".text.make(),
            elevation: 5,
            actions: [
              IconButton(
                onPressed: () {
                  journalNotifier.deleteAll();
                },
                icon: const Icon(Icons.delete_forever_rounded,
                    color: Colors.purple),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddJournalPage(
                            journalNotifier: journalNotifier,
                          )));
            },
            child: const Icon(Icons.add),
          ).p(15),
          body: SafeArea(
            child: ListView(
              children: [
                if (journalNotifier.journalList.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.heightBox,
                      Lottie.asset(Assets.lottie.empty),
                      15.heightBox,
                      "No Journals 🥲 😞".text.xl4.red400.bold.makeCentered(),
                    ],
                  )
                else
                  StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      for (int i = 0;
                          i < journalNotifier.journalList.length;
                          i++)
                        StaggeredGridTile.count(
                          crossAxisCellCount:
                              Constants.randomGridStructure[i % 5][0],
                          mainAxisCellCount:
                              Constants.randomGridStructure[i % 5][1],
                          child: Stack(
                            children: [
                              JournalCardWidget(
                                index: i,
                                journalModel: journalNotifier.journalList[i],
                                type: Constants.type_[i % 7],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      journalNotifier.deleteJournal(i);
                                    },
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.red,
                                    )),
                              )
                            ],
                          ),
                        )
                    ],
                  ).px(8).py(12)
              ],
            ),
          ),
        );
      }),
    );
  }
}
