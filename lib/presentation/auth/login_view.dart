import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/utils/validation.dart';
import 'package:chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat/presentation/auth/cubit/auth_state.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late AuthCubit _authCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.secondary,
            ),
          );
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.error,
            ),
          );
        }
      },
      child: Scaffold(
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
              CustomTextFormField(
                autofillHints: const [AutofillHints.email],
                controller: email,
                hintText: 'E-mail',
                prefix: Icons.email,
                validator: (value) {
                  return Validation.validateEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                controller: password,
                autofillHints: const [AutofillHints.password],
                hintText: 'Password',
                prefix: Icons.lock,
                validator: (value) {
                  return Validation.validatePassword(value);
                },
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: state is LoginLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await _authCubit.loginUser(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                            },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: state is LoginLoading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.register);
                },
                child: const Text("Don't have account ? register"),
              ),
            ],
          ).horizontalPadding(16),
        ),
      ),
    );
  }
}
