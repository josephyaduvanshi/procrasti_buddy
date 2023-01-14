import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:procrasti_buddy/services/http_helper/http_helper.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/chat_model.dart';

class SpeechToTextProvider extends ChangeNotifier {
  late SpeechToText _speechToText;

  late FlutterTts tts;
  final BuildContext context;
  bool _isListening = false;
  String _transcription = '';
  bool _isAIImageHidden = false;

  final List<ChatBotModel> _chatBotModelList = [];

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  List<ChatBotModel> get chatBotModelList => _chatBotModelList;
  bool get isAIImageHidden => _isAIImageHidden;
  bool get isListening => _isListening;
  String get transcription => _transcription;

  void toggleAIImageVisibility() {
    _isAIImageHidden = !_isAIImageHidden;
    notifyListeners();
  }

  SpeechToTextProvider(this.context) {
    _speechToText = SpeechToText();
    tts = FlutterTts();
  }

  Future<void> speakWord(String word) async {
    // await tts.setSpeechRate(0.58);
    await tts.speak(word);
    notifyListeners();
  }

  // Future<void> startListening() async {
  //   _transcription = '';
  //   _speechToText.listen(
  //     onResult: (result) {
  //       _transcription = result.recognizedWords;
  //       notifyListeners();
  //     },
  //     listenFor: const Duration(seconds: 5),
  //     pauseFor: const Duration(seconds: 5),
  //     onSoundLevelChange: (level) {
  //       log('onSoundLevelChange: $level');
  //     },
  //     cancelOnError: true,
  //     partialResults: true,
  //   );
  // }

  Future<void> stopSpeaking() async {
    await tts.stop();
    notifyListeners();
  }

  Future<bool> initialize() async {
    _speechToText = SpeechToText();
    bool resp = await _speechToText.initialize(
        onStatus: (status) async {
          log('onStatus: $status');
          // if (status == 'done') {
          //
          // }
        },
        onError: (error) => log('onError: $error'));
    return resp;
  }

  Future<void> finalStartBot() async {
    log('finalStartBot');
    if (!_isListening) {
      bool chek = await initialize();
      log(chek.toString());
      if (chek) {
        _isListening = true;
        await startListening();
        notifyListeners();
      }
    } else {
      await stopBot();
      notifyListeners();
    }
  }

  Future<void> stopBot() async {
    log('stopBot');
    _isListening = false;
    await _speechToText.stop();
    await sendMessage();
    notifyListeners();
  }

  Future<void> startListening() async {
    await _speechToText
        .listen(
          onResult: (result) {
            _transcription = result.recognizedWords;
            notifyListeners();
          },
        )
        .onError((error, stackTrace) => print('onError: $error'))
        .catchError((error) => print('catchError: $error'),
            test: (error) => error is Error);
  }

  Future<void> sendMessage() async {
    String input = _transcription;
    if (input.isNotEmpty) {
      _chatBotModelList.add(ChatBotModel(
        message: input,
        isUser: true,
        time: DateTime.now(),
      ));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
      notifyListeners();
      String? response = await _getResponse(input);
      print(response);
      Future.delayed(const Duration(milliseconds: 100), () {
        _chatBotModelList.add(
          ChatBotModel(
            message: response!,
            isUser: false,
            time: DateTime.now(),
          ),
        );
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
        notifyListeners();
      });
    }
  }

  Future<String?> _getResponse(String input) async {
    final aiResponse = await HttpHelper().getOpenAiResponse(promptHuman: input);
    return aiResponse.choices![0]!.text!.trim();
  }
}
