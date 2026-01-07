import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/presentation/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eman Tharwat')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const ChatBubble(isSender: true);
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
          ],
        ).allPadding(16),
      ),
    );
  }
}
