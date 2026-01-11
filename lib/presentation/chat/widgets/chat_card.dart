import 'package:chat/core/routing/routes.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chat);
      },
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name?[0] ?? '')),
        title: Text(user.name ?? 'unknown'),
        subtitle: Text(user.email ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
