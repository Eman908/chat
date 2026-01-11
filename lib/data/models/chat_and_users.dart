import 'package:chat/data/models/chat_model.dart';
import 'package:chat/data/models/user_model.dart';

class ChatAndUsers {
  final List<ChatModel> chats;
  final List<UserModel> users;

  ChatAndUsers({required this.chats, required this.users});
}
