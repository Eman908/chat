import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/data_source/contract/chat_data_source.dart';
import 'package:chat/data/models/chat_and_users.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/domain/repo/chat_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatDataSource _chatDataSource = getIt();

  @override
  Future<Results<UserModel>> searchUser({required String email}) async {
    return await _chatDataSource.searchUser(email: email);
  }

  @override
  Future<Results<ChatAndUsers>> loadUserChats({
    required String currentUserId,
  }) async {
    return await _chatDataSource.loadUserChats(currentUserId: currentUserId);
  }

  @override
  Future<Results<MessageModel>> addMessaged({
    required String chatId,
    required MessageModel message,
  }) async {
    var response = await _chatDataSource.addMessaged(
      chatId: chatId,
      message: message,
    );
    switch (response) {
      case Success<MessageModel>():
        return Success(null);
      case Failure<MessageModel>():
        return Failure(message: response.message);
    }
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return _chatDataSource.getMessages(chatId: chatId);
  }
}
