class ChatModel {
  String? chatId;
  String? lastMessage;
  List<String>? participants;

  ChatModel({this.chatId, this.lastMessage, this.participants});
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'],
      lastMessage: json['lastMessage'],
      participants: json['participants'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'participants': participants,
    };
  }
}
