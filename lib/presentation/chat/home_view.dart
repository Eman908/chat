import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:chat/presentation/chat/cubit/chat_state.dart';
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
  UserModel? _foundUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = context.read<ChatCubit>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.clear();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return BlocConsumer<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_preferences.getString(AppConstants.kName) ?? 'chats'),
            actions: [
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
            elevation: 0,
            shape: const Border(
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
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
                        _foundUser = null;
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: _searchUser,
                      child: state is SearchLoading
                          ? const CircularProgressIndicator()
                          : const Text('Search'),
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
      listener: (context, state) {
        if (state is SearchFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.error,
            ),
          );
        }

        if (state is SearchSuccess) {
          _foundUser = state.user;

          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add ${state.user.name}?'),
              content: Text(
                'Do you want to start a chat with ${state.user.name}?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_foundUser != null) {
                      cubit.createChat(_foundUser!);
                    }
                  },
                  child: const Text('Add Chat'),
                ),
              ],
            ),
          );
        }

        if (state is CreateChatFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.error,
            ),
          );
        }

        if (state is CreateChatSuccess) {
          Navigator.pop(context);
          email.clear();
          _foundUser = null;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Chat created successfully'),
              backgroundColor: context.color.secondary,
            ),
          );
        }
      },
    );
  }

  Widget _buildBody(ChatState state) {
    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.chat);
            },
            child: ListTile(
              leading: const CircleAvatar(),
              title: Text(_foundUser?.name ?? 'unknown'),
              subtitle: const Text('Where are you'),
              trailing: const Text('01:12 PM'),
            ),
          );
        },
      ),
    );
  }

  void _searchUser() {
    if (email.text.trim().isNotEmpty) {
      cubit.searchUser(email.text.trim());
    }
  }
}
