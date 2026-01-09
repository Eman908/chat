import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/core/error/safe_call.dart';
import 'package:chat/data/data_source/contract/chat_data_source.dart';
import 'package:chat/data/firebase/chats_service.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  final ChatsService _chatsService = getIt();
  final SharedPreferences _preferences = getIt();

  @override
  Future<Results<UserModel>> searchUser({required String email}) async {
    return safeCall(() async {
      final currentUserId = _preferences.getString(AppConstants.kUid) ?? '';

      final user = await _chatsService.searchUserWithChatCheck(
        email: email,
        currentUserId: currentUserId,
      );

      if (user == null) {
        return Failure(message: 'User not found');
      }

      return Success(user);
    });
  }

  @override
  Future<Results<void>> createChat({
    required String currentUserId,
    required String otherUserId,
  }) async {
    return safeCall(() async {
      await _chatsService.createChatIfNotExists(
        currentUserId: currentUserId,
        otherUserId: otherUserId,
      );
      return Success(null);
    });
  }
}
