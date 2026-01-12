import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/chat_and_users.dart';
import 'package:chat/data/models/user_model.dart';

abstract class ChatDataSource {
  Future<Results<UserModel>> searchUser({required String email});
  Future<Results<ChatAndUsers>> loadUserChats({required String currentUserId});
}
