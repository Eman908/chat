import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/domain/repo/chat_repo.dart';
import 'package:chat/presentation/chat/messages_cubit/messages_cubit.dart';
import 'package:chat/presentation/chat/messages_cubit/messages_state.dart';
import 'package:chat/presentation/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.name, required this.chatId});
  final String name;
  final String chatId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late MessagesCubit cubit;
  TextEditingController message = TextEditingController();
  final SharedPreferences _preferences = getIt();
  late Stream<List<MessageModel>> _messagesStream;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    cubit = context.read<MessagesCubit>();
    _messagesStream = getIt<ChatRepo>().getMessages(chatId: widget.chatId);
  }

  @override
  void dispose() {
    super.dispose();
    message.dispose();
    _focusNode.dispose();
  }

  void _sendMessage() {
    if (message.text.isEmpty) return;

    String currentUser = _preferences.getString(AppConstants.kUid)!;

    MessageModel messages = MessageModel(
      message: message.text,
      time: DateTime.now(),
      messagesId: '',
      senderId: currentUser,
    );

    cubit.setChat(widget.chatId, messages);

    message.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Expanded(
                    child: Center(child: Text('Something went wrong')),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data ?? [];
                  String currentUser = _preferences.getString(
                    AppConstants.kUid,
                  )!;
                  return Expanded(
                    child: data.isEmpty
                        ? const Center(child: Text('No Messages Yet'))
                        : ListView.separated(
                            reverse: true,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 24),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ChatBubble(
                                currentUser: currentUser,
                                messageModel: data[index],
                              );
                            },
                          ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: context.color.onPrimary),
                    controller: message,
                    textInputAction: TextInputAction.send,
                    focusNode: _focusNode,
                    onSubmitted: (value) {
                      _sendMessage();
                    },
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: () {
                          //TODO show icons
                        },
                        child: const Icon(Icons.emoji_emotions_outlined),
                      ),
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<MessagesCubit, MessagesState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send),
                    );
                  },
                ),
              ],
            ).allPadding(16),
          ],
        ),
      ),
    );
  }
}
