import 'package:chat/core/routing/routes.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode)),
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
