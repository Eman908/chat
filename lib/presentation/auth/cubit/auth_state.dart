import 'package:chat/data/models/user_model.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterFailure extends AuthState {
  final String message;
  RegisterFailure({required this.message});
}

final class RegisterSuccess extends AuthState {
  UserModel userModel;
  RegisterSuccess(this.userModel);
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;
  LoginFailure({required this.message});
}

final class LoginSuccess extends AuthState {
  String message;
  LoginSuccess(this.message);
}
