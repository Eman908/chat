import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isSender});
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender
          ? AlignmentGeometry.centerRight
          : AlignmentGeometry.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSender
              ? context.color.secondary
              : context.color.onSecondary.withBlue(50),
          borderRadius: isSender
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
        child: const Text(
          'heheheheh',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
