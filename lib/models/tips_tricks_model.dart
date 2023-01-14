import 'dart:convert';

class TipsTricksModel {
  TipsTricksModel({
    this.tips,
  });

  final List<Tip?>? tips;

  factory TipsTricksModel.fromJson(String str) =>
      TipsTricksModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipsTricksModel.fromMap(Map<String, dynamic> json) => TipsTricksModel(
        tips: json["tips"] == null
            ? []
            : List<Tip?>.from(json["tips"]!.map((x) => Tip.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "tips": tips == null
            ? []
            : List<dynamic>.from(tips!.map((x) => x!.toMap())),
      };
}

class Tip {
  Tip({
    this.tip,
    this.explanation,
  });

  final String? tip;
  final String? explanation;

  factory Tip.fromJson(String str) => Tip.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tip.fromMap(Map<String, dynamic> json) => Tip(
        tip: json["tip"],
        explanation: json["explanation"],
      );

  Map<String, dynamic> toMap() => {
        "tip": tip,
        "explanation": explanation,
      };
}

TipsTricksModel tipsTricksModelFromMap(jsonString) {
  final jsonData = json.decode(jsonString);
  return TipsTricksModel.fromMap(jsonData);
}
