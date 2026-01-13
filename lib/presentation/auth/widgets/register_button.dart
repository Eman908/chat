import 'package:chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat/presentation/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.authCubit,
    required this.email,
    required this.password,
    required this.name,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final AuthCubit authCubit;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            onPressed: state is RegisterLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      await authCubit.registerUser(
                        email: email.text,
                        password: password.text,
                        name: name.text,
                      );
                    }
                  },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: state is RegisterLoading
                ? const CircularProgressIndicator()
                : const Text('Sign Up'),
          ),
        );
      },
    );
  }
}
