import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_colors.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/data/firebase/firebase_service.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:chat/presentation/chat/cubit/chat_state.dart';
import 'package:chat/presentation/chat/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ChatCubit cubit;
  TextEditingController email = TextEditingController();
  final SharedPreferences _preferences = getIt();

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChatCubit>();
    cubit.loadChatsAndUsers();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      builder: (context, state) {
        var provider = Provider.of<ThemeProvider>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(_preferences.getString(AppConstants.kName) ?? 'chats'),
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseService().signOutUser();
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
              ),
              IconButton(
                onPressed: () {
                  ThemeMode newTheme;
                  switch (provider.appTheme) {
                    case ThemeMode.dark:
                      newTheme = ThemeMode.light;
                      break;
                    case ThemeMode.light:
                      newTheme = ThemeMode.system;
                      break;
                    case ThemeMode.system:
                      newTheme = ThemeMode.dark;
                  }
                  provider.changeTheme(newTheme);
                },
                icon: Icon(
                  provider.appTheme == ThemeMode.dark
                      ? Icons.dark_mode
                      : provider.appTheme == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.brightness_auto,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              email.clear();
              showDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  constraints: BoxConstraints(
                    minWidth: context.widthSized - 16,
                  ),
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
          ),
          body: _buildBody(state),
        );
      },
      listener: (BuildContext context, ChatState state) {
        if (state is SearchSuccess) {
          Navigator.pop(context);
          email.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added Successfully'),
              backgroundColor: AppColors.green,
            ),
          );
          cubit.loadChatsAndUsers();
        } else if (state is SearchFailure) {
          Navigator.pop(context);
          email.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.error,
            ),
          );
          // cubit.loadChatsAndUsers();
        }
      },
    );
  }

  Widget _buildBody(ChatState state) {
    if (state is ChatListLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ChatListSuccess) {
      final chatAndUsers = state.users;

      if (chatAndUsers.chats.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              const Text(
                'No chats yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a friend to start chatting',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: chatAndUsers.chats.length,
        itemBuilder: (context, index) {
          final chat = chatAndUsers.chats[index];
          final user = index < chatAndUsers.users.length
              ? chatAndUsers.users[index]
              : null;

          return ChatCard(user: user!, chatModel: chat);
        },
      );
    }

    if (state is ChatListFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.message}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => cubit.loadChatsAndUsers(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
