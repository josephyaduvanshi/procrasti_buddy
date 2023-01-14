import 'package:flutter/material.dart';
import 'package:procrasti_buddy/services/notifiers/journal_notifier.dart';
import 'package:procrasti_buddy/widgets/mood_widget_journal.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/constants/constants.dart';

class AddJournalPage extends StatefulWidget {
  final JournalNotifier journalNotifier;
  const AddJournalPage({
    Key? key,
    required this.journalNotifier,
  }) : super(key: key);

  @override
  AddJournalPageState createState() => AddJournalPageState();
}

class AddJournalPageState extends State<AddJournalPage> {
  @override
  Widget build(BuildContext context) {
    late JournalNotifier journalNotifier = widget.journalNotifier;
    return Scaffold(
      appBar: AppBar(
        title: "Add Journal".text.make(),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_as_rounded, color: Colors.purple),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3B3B3B),
        onPressed: journalNotifier.finalAddJournalToDb,
        child: const Icon(Icons.save_as_rounded),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: journalNotifier.formKey,
          child: SafeArea(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: journalNotifier.titleTextController,
                      style: Constants.titleTextStyle,
                      maxLines: 3,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    8.heightBox,
                    const MoodJournalWidget(),
                    "Description"
                        .text
                        .bold
                        .xl
                        .caption(context)
                        .make()
                        .py(12)
                        .px(8),
                    TextFormField(
                      controller: journalNotifier.descriptionTextController,
                      style: Constants.descriptionTextStyle,
                      minLines: 20,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                      maxLines: 50,
                      decoration: InputDecoration(
                        hintText: "Type something...",
                        hintStyle: Constants.descriptionTextStyle,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).px(16).py(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
