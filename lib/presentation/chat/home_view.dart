import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/data/firebase/firebase_service.dart';
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
    cubit.loadChats();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
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
                      : (provider.appTheme == ThemeMode.light)
                      ? Icons.light_mode
                      : Icons.brightness_auto,
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddDialog(context),
            child: const Icon(Icons.add),
          ),

          body: _buildBody(),
        );
      },
      listener: (context, state) {
        if (state is SearchSuccess) {
          Navigator.pop(context);
        }

        if (state is CreateChatSuccess) {
          cubit.loadChats();
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Chat added!')));
        }

        if (state is SearchFailure || state is CreateChatFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('wrong'), backgroundColor: Colors.red),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    final users = cubit.chatUsers;

    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, size: 80, color: Colors.grey[300]),
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
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ChatCard(user: user);
      },
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Friend'),
        content: TextField(
          controller: email,
          decoration: const InputDecoration(
            hintText: 'Enter email',
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (email.text.isNotEmpty) {
                cubit.searchUser(email.text);
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
