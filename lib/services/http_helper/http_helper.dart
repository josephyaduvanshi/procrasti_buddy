import 'package:http/http.dart' as http;
import 'package:procrasti_buddy/models/tips_tricks_model.dart';

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
}
