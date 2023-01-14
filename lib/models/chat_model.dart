class ChatBotModel {
  final String message;
  final DateTime time;
  final bool isUser;
  ChatBotModel(
      {required this.message, required this.time, required this.isUser});
}
