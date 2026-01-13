import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/chat_and_users.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/models/user_model.dart';

abstract class ChatRepo {
  Future<Results<UserModel>> searchUser({required String email});
  Future<Results<MessageModel>> addMessaged({
    required String chatId,
    required MessageModel message,
  });
  Future<Results<ChatAndUsers>> loadUserChats({required String currentUserId});
  Stream<List<MessageModel>> getMessages({required String chatId});
}
