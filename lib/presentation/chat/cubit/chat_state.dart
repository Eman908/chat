import 'package:chat/data/models/user_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatListLoading extends ChatState {}

class ChatListSuccess extends ChatState {
  final List<UserModel> users;
  ChatListSuccess(this.users);
}

class ChatListFailure extends ChatState {
  final String message;
  ChatListFailure({required this.message});
}

class SearchLoading extends ChatState {}

class SearchSuccess extends ChatState {
  final UserModel user;
  SearchSuccess(this.user);
}

class SearchFailure extends ChatState {
  final String message;
  SearchFailure({required this.message});
}

class CreateChatLoading extends ChatState {}

class CreateChatSuccess extends ChatState {}

class CreateChatFailure extends ChatState {
  final String message;
  CreateChatFailure({required this.message});
}
