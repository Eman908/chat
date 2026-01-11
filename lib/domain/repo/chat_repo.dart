import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/user_model.dart';

abstract class ChatRepo {
  Future<Results<UserModel>> searchUser({required String email});
  Future<Results<void>> createChat({
    required String currentUserId,
    required String otherUserId,
  });
  Future<Results<List<UserModel>>> loadUserChats({
    required String currentUserId,
  });
}
