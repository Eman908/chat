import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/theme/app_colors.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.messageModel,
    required this.currentUser,
  });
  final String currentUser;
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: currentUser == messageModel.senderId
          ? AlignmentGeometry.centerRight
          : AlignmentGeometry.centerLeft,
      child: Column(
        crossAxisAlignment: currentUser == messageModel.senderId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: currentUser == messageModel.senderId
                  ? context.color.secondary
                  : context.color.onSecondary.withBlue(50),
              borderRadius: currentUser == messageModel.senderId
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
            ),
            child: Text(
              messageModel.message,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
          Text(DateFormat('h:mm a').format(messageModel.time)),
        ],
      ),
    );
  }
}
