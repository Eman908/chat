import 'package:chat/core/routing/routes.dart';
import 'package:chat/data/models/chat_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.user, required this.chatModel});
  final UserModel user;
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chat);
      },
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name?[0] ?? '')),
        title: Text(user.name ?? 'unknown'),
        subtitle: chatModel.lastMessage == null
            ? const Text('No Messages Yet')
            : Text(chatModel.lastMessage!),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
