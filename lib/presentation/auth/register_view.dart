import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                child: const Text('Sign Up'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Already have account ? Login"),
            ),
          ],
        ).horizontalPadding(16),
      ),
    );
  }
}
