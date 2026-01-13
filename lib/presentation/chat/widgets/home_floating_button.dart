import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:chat/presentation/chat/chat_cubit/chat_cubit.dart';
import 'package:chat/presentation/chat/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({
    super.key,
    required this.email,
    required this.cubit,
  });

  final TextEditingController email;
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        email.clear();
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            constraints: BoxConstraints(minWidth: context.widthSized - 16),
            title: const Text('Add New Friend'),
            content: CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              controller: email,
              hintText: 'E-mail',
              prefix: Icons.email,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  email.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      cubit.addChat(email.text);
                    },
                    child: state is SearchLoading
                        ? const CircularProgressIndicator()
                        : const Text('Search'),
                  );
                },
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
