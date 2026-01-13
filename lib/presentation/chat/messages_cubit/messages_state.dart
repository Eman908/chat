sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class MessagesSuccess extends MessagesState {}

final class MessagesFailure extends MessagesState {
  final String message;
  MessagesFailure(this.message);
}
