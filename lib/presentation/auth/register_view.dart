import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/padding_extension.dart';
import 'package:chat/core/utils/validation.dart';
import 'package:chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat/presentation/auth/cubit/auth_state.dart';
import 'package:chat/presentation/auth/widgets/custom_text_field.dart';
import 'package:chat/presentation/auth/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late AuthCubit authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    name.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Register Success'),
              backgroundColor: context.color.secondary,
            ),
          );
          Navigator.pop(context);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.color.error,
            ),
          );
        }
      },
      child: Scaffold(
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
              CustomTextFormField(
                validator: (value) {
                  return Validation.validateName(value);
                },
                controller: name,
                hintText: 'Name',
                autofillHints: const [AutofillHints.name],
                prefix: Icons.person,
                keyboardType: TextInputType.name,
              ),
              CustomTextFormField(
                validator: (value) {
                  return Validation.validateEmail(value);
                },
                controller: email,
                hintText: 'E-mail',
                autofillHints: const [AutofillHints.email],
                prefix: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                validator: (value) {
                  return Validation.validatePassword(value);
                },
                controller: password,
                hintText: 'Password',
                autofillHints: const [AutofillHints.password],
                prefix: Icons.lock,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              RegisterButton(
                formKey: _formKey,
                authCubit: authCubit,
                email: email,
                password: password,
                name: name,
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
      ),
    );
  }
}
