import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/domain/repo/chat_repo.dart';
import 'package:chat/presentation/chat/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final ChatRepo _chatRepo = getIt();
  final SharedPreferences _preferences = getIt();

  Future<void> searchUser(String email) async {
    emit(SearchLoading());

    final response = await _chatRepo.searchUser(email: email.toLowerCase());

    switch (response) {
      case Success<UserModel>():
        emit(SearchSuccess(response.data!));
      case Failure<UserModel>():
        emit(SearchFailure(message: response.message ?? 'User not found'));
    }
  }

  Future<void> createChat(UserModel otherUser) async {
    emit(CreateChatLoading());

    final currentUserId = _preferences.getString(AppConstants.kUid) ?? '';

    final response = await _chatRepo.createChat(
      currentUserId: currentUserId,
      otherUserId: otherUser.uId!,
    );

    switch (response) {
      case Success<void>():
        emit(CreateChatSuccess());
      case Failure<void>():
        emit(
          CreateChatFailure(
            message: response.message ?? 'Failed to create chat',
          ),
        );
    }
  }
}
