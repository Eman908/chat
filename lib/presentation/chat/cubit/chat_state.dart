import 'package:chat/data/models/user_model.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SearchSuccess extends ChatState {
  final UserModel user;
  SearchSuccess(this.user);
}

final class SearchFailure extends ChatState {
  final String message;
  SearchFailure({required this.message});
}

final class SearchLoading extends ChatState {}

final class CreateChatSuccess extends ChatState {}

final class CreateChatFailure extends ChatState {
  final String message;
  CreateChatFailure({required this.message});
}

final class CreateChatLoading extends ChatState {}
