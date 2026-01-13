import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/domain/repo/chat_repo.dart';
import 'package:chat/presentation/chat/messages_cubit/messages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());
  final ChatRepo _chatRepo = getIt();
  Future<void> setChat(String chatId, MessageModel message) async {
    var response = await _chatRepo.addMessaged(
      chatId: chatId,
      message: message,
    );
    switch (response) {
      case Success<MessageModel>():
        emit(MessagesSuccess());
      case Failure<MessageModel>():
        emit(MessagesFailure(response.message ?? 'something went wrong'));
    }
  }
}
