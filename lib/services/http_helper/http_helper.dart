import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:procrasti_buddy/models/tips_tricks_model.dart';

import '../../models/open_ai_chat_model.dart';
import '../../utils/constants/constants.dart';

class HttpHelper {
  final client = http.Client();
  Future<TipsTricksModel> getProcastinationTips() async {
    try {
      String url =
          "https://raw.githubusercontent.com/josephyaduvanshi/UpdatesAndRemoteApi/main/dictionary/procastination_remedy.json";
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        final tipsTricksModel = tipsTricksModelFromMap(data);
        return tipsTricksModel;
      } else {
        return TipsTricksModel();
      }
    } catch (e) {
      return TipsTricksModel();
    }
  }

  Future<OpenAiChatModel> getOpenAiResponse({
    required String promptHuman,
  }) async {
    try {
      String apiKey = Constants.openApiKey.toString();
      String url = "https://api.openai.com/v1/completions";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };
      Map<String, dynamic> body = {
        "model": "text-davinci-003",
        "prompt": "Human: , $promptHuman\nAI:",
        "temperature": 0,
        "max_tokens": 100,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": [" Human:", " AI:"]
      };
      final response = await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        String data = response.body;
        final openAiChatModel = openAiChatModelFromMap(data);
        log(openAiChatModel.choices![0]!.text.toString());
        return openAiChatModel;
      } else {
        log(response.body);
        return OpenAiChatModel(
          choices: [
            Choice(
              text: "Network Error!",
            ),
          ],
        );
      }
    } catch (e) {
      log(e.toString());
      return OpenAiChatModel(
        choices: [
          Choice(
            text: "Unexpected Error Occured!",
          ),
        ],
      );
    }
  }
}
