import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
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
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              title: const Text('Add New Friend'),
              content: const CustomTextFormField(
                hintText: 'E-mail',
                prefix: Icons.email,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Add')),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.chat);
              },
              child: const ListTile(
                leading: CircleAvatar(),
                title: Text('Eman Tharwat'),
                subtitle: Text('Where are you'),
                trailing: Text('01:12 PM'),
              ),
            );
          },
        ),
      ),
    );
  }
}
