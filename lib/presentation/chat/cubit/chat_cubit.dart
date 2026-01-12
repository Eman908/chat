import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/chat_and_users.dart';
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
  ChatAndUsers? _cachedChats;

  Future<void> addChat(String email) async {
    emit(SearchLoading());
    var response = await _chatRepo.searchUser(email: email);
    switch (response) {
      case Success<UserModel>():
        emit(SearchSuccess(response.data!));
        await loadChatsAndUsers();
      case Failure<UserModel>():
        emit(
          SearchFailure(message: response.message ?? 'Something went wrong'),
        );
    }
    if (_cachedChats != null) {
      emit(ChatListSuccess(_cachedChats!));
    }
  }

  Future<void> loadChatsAndUsers() async {
    emit(ChatListLoading());
    final currentUserId = _preferences.getString(AppConstants.kUid) ?? '';
    var response = await _chatRepo.loadUserChats(currentUserId: currentUserId);
    switch (response) {
      case Success<ChatAndUsers>():
        _cachedChats = response.data;
        emit(ChatListSuccess(response.data!));
      case Failure<ChatAndUsers>():
        emit(
          ChatListFailure(message: response.message ?? 'Something went wrong'),
        );
    }
  }
}
