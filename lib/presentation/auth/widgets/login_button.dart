import 'package:chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat/presentation/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required AuthCubit authCubit,
    required this.email,
    required this.password,
  }) : _formKey = formKey,
       _authCubit = authCubit;

  final GlobalKey<FormState> _formKey;
  final AuthCubit _authCubit;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
    );
  }
}
