import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                provider.changeTheme(
                  provider.appTheme == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
              child: const Text('theme'),
            ),
            Text(
              'Chat App',
              style: context.textTheme.titleLarge!.copyWith(
                color: context.color.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomTextFormField(
              hintText: 'E-mail',
              prefix: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const CustomTextFormField(
              hintText: 'Password',
              prefix: Icons.lock,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ).horizontalPadding(16),
      ),
    );
  }
}
