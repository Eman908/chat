import 'package:chat/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('data')),
          FilledButton(
            onPressed: () {
              provider.changeTheme(ThemeMode.system);
            },
            child: const Text('system'),
          ),
          FilledButton(
            onPressed: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: const Text('dark'),
          ),
          FilledButton(
            onPressed: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: const Text('light'),
          ),
        ],
      ),
    );
  }
}
