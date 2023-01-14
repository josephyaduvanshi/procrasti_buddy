import 'dart:convert';

class OpenAiChatModel {
  OpenAiChatModel({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
  });

  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<Choice?>? choices;
  final Usage? usage;

  factory OpenAiChatModel.fromJson(String str) =>
      OpenAiChatModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OpenAiChatModel.fromMap(Map<String, dynamic> json) => OpenAiChatModel(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices: json["choices"] == null
            ? []
            : List<Choice?>.from(
                json["choices"]!.map((x) => Choice.fromMap(x))),
        usage: Usage.fromMap(json["usage"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": choices == null
            ? []
            : List<dynamic>.from(choices!.map((x) => x!.toMap())),
        "usage": usage!.toMap(),
      };
}

class Choice {
  Choice({
    this.text,
    this.index,
    this.logprobs,
    this.finishReason,
  });

  final String? text;
  final int? index;
  final dynamic logprobs;
  final String? finishReason;

  factory Choice.fromJson(String str) => Choice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Choice.fromMap(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "index": index,
        "logprobs": logprobs,
        "finish_reason": finishReason,
      };
}

class Usage {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;

  factory Usage.fromJson(String str) => Usage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usage.fromMap(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toMap() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}

OpenAiChatModel openAiChatModelFromMap(jsonString) {
  final dataFromMap = json.decode(jsonString);
  return OpenAiChatModel.fromMap(dataFromMap);
}
