import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';
import 'package:procrasti_buddy/services/notifiers/speech_to_text_notifier.dart';
import 'package:procrasti_buddy/views/ai_assistant/human_prompt_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'ai_assistant_ui_widget.dart';

class ProcrastiBuddyAIPage extends StatelessWidget {
  const ProcrastiBuddyAIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SpeechToTextProvider>(context, listen: false).dispose();
        return true;
      },
      child: ChangeNotifierProvider.value(
        value: SpeechToTextProvider(context),
        child: Consumer(builder:
            (context, SpeechToTextProvider speechToTextProvider, child) {
          return Stack(
            children: [
              Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButton: AvatarGlow(
                  glowColor: Colors.blue,
                  showTwoGlows: true,
                  animate: speechToTextProvider.isListening,
                  endRadius: 86,
                  child: FloatingActionButton(
                    enableFeedback: true,
                    onPressed: speechToTextProvider.finalStartBot,
                    child: const Icon(Icons.mic),
                  ),
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    !speechToTextProvider.isAIImageHidden
                        ? ListView(
                            shrinkWrap: true,
                            children: [
                              Lottie.asset(Assets.lottie.botAi,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  width:
                                      MediaQuery.of(context).size.width * 0.17),
                            ],
                          )
                        : const SizedBox(),
                    HumanMessagePromptWidget(
                      message: speechToTextProvider.transcription,
                    ).py(8),
                    Expanded(
                      child: AICHatBotUIWidget(
                        scrollController: speechToTextProvider.scrollController,
                        messages: speechToTextProvider.chatBotModelList,
                        speechToTextProvider: speechToTextProvider,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  enableFeedback: true,
                  onPressed: speechToTextProvider.toggleAIImageVisibility,
                  color: !speechToTextProvider.isAIImageHidden
                      ? Colors.blue
                      : Colors.grey,
                  icon: Icon(
                    !speechToTextProvider.isAIImageHidden
                        ? Icons.remove_red_eye_rounded
                        : Icons.visibility_off_rounded,
                  ),
                ),
              ).px(16)
            ],
          );
        }),
      ),
    );
  }
}
