import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chat_model.dart';
import '../../services/notifiers/speech_to_text_notifier.dart';

class AICHatBotUIWidget extends StatelessWidget {
  final List<ChatBotModel> messages;
  final ScrollController scrollController;
  final SpeechToTextProvider speechToTextProvider;

  const AICHatBotUIWidget(
      {Key? key,
      required this.messages,
      required this.scrollController,
      required this.speechToTextProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => speechToTextProvider,
      child: Consumer(
          builder: (context, SpeechToTextProvider speechToTextProvider, child) {
        return ListView.builder(
          shrinkWrap: true,
          controller: scrollController,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == messages.length - 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });
            }
            return messages[index].isUser
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(messages[index].message,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          messages[index].message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
          },
        );
      }),
    );
  }
}
